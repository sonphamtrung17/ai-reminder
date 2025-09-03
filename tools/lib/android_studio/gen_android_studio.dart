// ignore_for_file: avoid_print

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:xml/xml.dart';
import 'package:yaml/yaml.dart';

import '../common/constants.dart';
import 'conf_skeleton.dart';

final List<String> flutterCommands = ['run', 'release'];

// Logging helpers
void logInfo(String message) => print('🔍 [INFO] $message');

void logSuccess(String message) => print('✅ [SUCCESS] $message');

void logWarn(String message) => print('⚠️ [WARN] $message');

void logError(String message) => print('❌ [ERROR] $message');

class AndroidStudioEnvGenerator {
  AndroidStudioEnvGenerator();

  void call() {
    try {
      final resolvedWorkspacePath = _resolveWorkspaceXmlPath(workspaceXmlPath);
      logInfo('Resolved workspace.xml path: $resolvedWorkspacePath');

      final settingsFile = File(resolvedWorkspacePath);
      if (!settingsFile.existsSync()) {
        logWarn('workspace.xml not found. Creating new from skeleton...');
        settingsFile.createSync(recursive: true);
        settingsFile.writeAsStringSync(workspaceSkeleton);
        logSuccess('workspace.xml created successfully!');
      } else {
        logInfo('workspace.xml found. Proceeding to update...');
      }

      ConfigXmlWriter(filePath: resolvedWorkspacePath).call();
      logSuccess('Android Studio Run Configs updated.');
    } on FormatException catch (e) {
      logError('workspace.xml is not valid XML format: $e');
    } on FileSystemException catch (e) {
      logError('workspace.xml does not exist! $e');
    }
  }

  String _resolveWorkspaceXmlPath(String relativePath) {
    Directory dir = Directory.current;
    while (true) {
      final candidate = File('${dir.path}/.idea/workspace.xml');
      if (candidate.existsSync()) {
        return candidate.path;
      }
      final parent = dir.parent;
      if (parent.path == dir.path) {
        break;
      }
      dir = parent;
    }
    return relativePath; // fallback
  }
}

class ConfigXmlWriter {
  final String filePath;

  ConfigXmlWriter({required this.filePath});

  void call() {
    final mandatoryFile = File(filePath);
    logInfo('Reading existing workspace.xml...');
    final originalContent = mandatoryFile.readAsStringSync();
    logInfo('Parsing XML...');
    final updatedContent = writeConfig(originalContent);
    mandatoryFile.writeAsStringSync(updatedContent);
    logSuccess('workspace.xml updated successfully!');
  }

  String writeConfig(String fileContent) {
    final XmlDocument document = XmlDocument.parse(fileContent);
    logInfo('Validating XML structure...');
    validateConfFile(document);

    final envResult = _readEnvConfig();
    final flavors = envResult.keys.where((k) => k != 'environments').toList();
    logInfo(
      'Flavors detected: ${flavors.isEmpty ? "None" : flavors.join(", ")}',
    );

    final runConfRootElement = document
        .findAllElements('component')
        .firstWhereOrNull((e) => e.getAttribute('name') == 'RunManager');
    if (runConfRootElement == null) {
      throw FormatException;
    }

    _removeExistingFlutterConfigs(runConfRootElement);

    for (final command in flutterCommands) {
      for (final flavor in flavors) {
        logInfo('➡️ Generating config: $command $flavor');
        addOrReplaceConf(
          runConfRootElement,
          createRunConf(config: command, flavor: flavor, dartDefines: null),
        );
      }
    }

    return document.toXmlString(pretty: true, indent: '\t');
  }

  void validateConfFile(XmlDocument document) {
    final XmlElement? runConfRootElement = document
        .findAllElements('component')
        .firstWhereOrNull((e) => e.getAttribute('name') == 'RunManager');

    if (runConfRootElement == null) {
      final projectRootElements = document.findAllElements('project');
      if (projectRootElements.isEmpty) {
        throw FormatException;
      }
      final XmlNode runManagerElement = createElementFromSkeleton(
        runManagerSkeleton,
      );
      projectRootElements.first.children.add(runManagerElement);
      logWarn('RunManager component not found. Added new RunManager skeleton.');
    }
  }

  XmlNode createRunConf({
    required String config,
    required String flavor,
    Map<String, String>? dartDefines,
  }) {
    final XmlNode newRunConfElement = createElementFromSkeleton(
      runConfigSkeletonXml,
    );
    newRunConfElement.setAttribute('name', '$config $flavor');

    final buildFlavorElement = newRunConfElement.childElements.firstWhere(
      (e) => e.getAttribute('name') == 'buildFlavor',
    );
    buildFlavorElement.setAttribute('value', flavor);

    // Ensure filePath points to correct entry file
    final entrypointPath = _resolveEntryFilePath();
    final filePathElement = newRunConfElement.childElements.firstWhere(
      (e) => e.getAttribute('name') == 'filePath',
    );
    filePathElement.setAttribute('value', entrypointPath);

    final dartDefinesElement = newRunConfElement.childElements.firstWhere(
      (e) => e.getAttribute('name') == 'additionalArgs',
    );
    dartDefinesElement.setAttribute(
      'value',
      getAdditionalArgs(
        command: config,
        flavor: flavor,
        dartDefines: dartDefines,
      ),
    );

    return newRunConfElement;
  }

  XmlNode createMakeConf({required String target}) {
    final XmlNode newMakeConfElement = createElementFromSkeleton(
      makeConfigSkeletonXml,
    );
    newMakeConfElement.setAttribute('name', 'make $target');
    final targetElement = newMakeConfElement.findAllElements('makefile').first;
    targetElement.setAttribute('target', target);
    return newMakeConfElement;
  }

  XmlNode createElementFromSkeleton(String skeleton) {
    final XmlNode? element = XmlDocument.parse(skeleton).firstChild?.copy();
    if (element == null) {
      throw FormatException;
    }
    return element;
  }

  String getAdditionalArgs({
    required String flavor,
    String? command,
    Map<String, String>? dartDefines,
  }) {
    final buffer = StringBuffer();
    if (command != null && !command.contains('run')) {
      buffer.write('--$command ');
    }
    buffer.write('--flavor $flavor --dart-define FLAVOR=$flavor');
    return buffer.toString().trimRight();
  }

  String _resolveEntryFilePath() {
    // Prefer app/lib/main.dart if exists, else fallback to lib/main.dart
    // Android Studio expects PROJECT_DIR-based path strings
    final projectDir = Directory.current.path;
    final appMain = File('$projectDir/app/lib/main.dart');
    if (appMain.existsSync()) {
      return r'$PROJECT_DIR$/app/lib/main.dart';
    }
    final rootMain = File('$projectDir/lib/main.dart');
    if (rootMain.existsSync()) {
      return r'$PROJECT_DIR$/lib/main.dart';
    }
    // fallback: still point to app/lib/main.dart to surface clear error
    return r'$PROJECT_DIR$/app/lib/main.dart';
  }

  void addOrReplaceConf(XmlElement rootElement, XmlNode newConf) {
    final XmlNode? existingElement = rootElement.children.firstWhereOrNull(
      (e) => e.getAttribute('name') == newConf.getAttribute('name'),
    );
    if (existingElement != null) {
      logWarn('Replacing existing config: ${newConf.getAttribute('name')}');
      rootElement.children.remove(existingElement);
    }
    rootElement.children.add(newConf);
  }

  void _removeExistingFlutterConfigs(XmlElement runConfRootElement) {
    final toRemove = <XmlNode>[];
    for (final child in runConfRootElement.children) {
      final type = child.getAttribute('type');
      // Loại bỏ toàn bộ cấu hình Flutter hiện có (Android Studio tự tạo như "Flutter Run -> 'app'")
      if (type == 'FlutterRunConfigurationType') {
        toRemove.add(child);
        continue;
      }
      // Dọn các cấu hình Dart không mong muốn liên quan tới tools
      final filePathOption = child.childElements.firstWhereOrNull(
        (e) => e.getAttribute('name') == 'filePath',
      );
      final filePathValue = filePathOption?.getAttribute('value') ?? '';
      if (filePathValue.endsWith('tools/lib/main.dart')) {
        toRemove.add(child);
      }
    }

    if (toRemove.isNotEmpty) {
      logWarn('Removing ${toRemove.length} old configs (Flutter/Dart)...');
    }
    for (final node in toRemove) {
      runConfRootElement.children.remove(node);
    }
  }

  Map<String, Map<String, String>> _readEnvConfig() {
    try {
      final resolvedPath = _resolveEnvConfigPath('env_config.yaml');
      logInfo('env_config.yaml path: $resolvedPath');

      final configFile = File(resolvedPath);
      if (!configFile.existsSync()) {
        logWarn('env_config.yaml not found. Using empty config.');
        return {};
      }

      final content = configFile.readAsStringSync();
      final YamlMap yamlMap = loadYaml(content);
      final YamlMap? environments = yamlMap['environments'];

      if (environments == null) {
        logWarn('"environments" not found in env_config.yaml.');
        return {};
      }

      final result = <String, Map<String, String>>{};
      environments.nodes.forEach((keyNode, valueNode) {
        final String flavor = keyNode.value.toString();
        final YamlMap envDetail = valueNode.value as YamlMap? ?? YamlMap();
        final YamlMap variables =
            envDetail['variables'] as YamlMap? ?? YamlMap();

        final Map<String, String> defines = {
          flavorKey: flavor,
          ...variables.map((k, v) => MapEntry(k.toString(), v.toString())),
        };
        result[flavor] = defines;
      });

      logSuccess('Loaded ${result.length} environment(s) from env_config.yaml');
      return result;
    } catch (e) {
      logError('Error while reading env_config.yaml: $e');
      return {};
    }
  }

  String _resolveEnvConfigPath(String fileName) {
    Directory dir = Directory.current;
    while (true) {
      final candidate = File('${dir.path}/$fileName');
      if (candidate.existsSync()) {
        return candidate.path;
      }
      final parent = dir.parent;
      if (parent.path == dir.path) {
        break;
      }
      dir = parent;
    }
    return fileName; // fallback
  }
}
