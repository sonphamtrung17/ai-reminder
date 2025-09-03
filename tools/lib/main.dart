import 'dart:async';
import 'dart:io';

import 'package:yaml/yaml.dart';

import 'android_studio/gen_android_studio.dart';

Future<void> main() async {
  _log('🚀 Bắt đầu generate flavors + run configurations');

  final envConfigPath = _resolvePath([
    'env_config.yaml',
    '../env_config.yaml',
    'app/env_config.yaml',
    '../app/env_config.yaml',
  ]);
  final envFile = File(envConfigPath);
  if (!envFile.existsSync()) {
    _err('Không tìm thấy env_config.yaml tại root hoặc app/.');
    exit(1);
  }

  final YamlMap yaml = loadYaml(envFile.readAsStringSync());
  final YamlMap? environments = yaml['environments'];
  if (environments == null || environments.isEmpty) {
    _err('env_config.yaml không có key environments hoặc rỗng.');
    exit(1);
  }

  _log('📂 Environments: ${environments.keys.join(', ')}');

  // 1) Generate .env files + Android flavors block + iOS xcconfig/project.yml
  final androidGradlePath = _resolvePath([
    'app/android/app/build.gradle.kts',
    '../app/android/app/build.gradle.kts',
  ]);
  final iosDirPath = _resolvePath(['app/ios', '../app/ios']);

  await _generateEnvAndFlavors(
    environments: environments,
    androidGradlePath: androidGradlePath,
    iosDirPath: iosDirPath,
  );

  // 2) Generate Android Studio Run Configurations
  // - Chỉ sao chép tạm env_config.yaml ra root nếu nguồn không ở root
  final rootEnvPath = _resolvePath(['env_config.yaml']);
  final bool needTempCopy = envFile.path != rootEnvPath;
  if (needTempCopy) {
    File(rootEnvPath).writeAsStringSync(envFile.readAsStringSync());
  }
  try {
    AndroidStudioEnvGenerator().call();
  } finally {
    if (needTempCopy) {
      try {
        File(rootEnvPath).deleteSync();
      } catch (_) {}
    }
  }

  _ok('✨ Hoàn tất generate flavors và Run Configurations');
}

Future<void> _generateEnvAndFlavors({
  required YamlMap environments,
  required String androidGradlePath,
  required String iosDirPath,
}) async {
  final envDir = Directory('app/env');
  if (!envDir.existsSync()) {
    envDir.createSync();
    _ok('📁 Đã tạo thư mục app/env/');
  }

  final bufferGradle = StringBuffer()
    ..writeln('flavorDimensions += "default"')
    ..writeln('productFlavors {');

  environments.forEach((key, value) {
    final String envName = key.toString();
    final YamlMap cfg = (value as YamlMap?) ?? YamlMap();
    final String appName = cfg['app_name']?.toString() ?? envName;
    final String bundleId =
        cfg['bundle_id']?.toString() ?? 'com.example.$envName';

    _log('🔧 Generating [$envName]');

    // Write env/.env.<env>
    final buf = StringBuffer();
    buf.writeln('APP_NAME=$appName');
    buf.writeln('BUNDLE_ID=$bundleId');
    final YamlMap variables = (cfg['variables'] as YamlMap?) ?? YamlMap();
    variables.forEach((k, v) => buf.writeln('${k.toString()}=${v.toString()}'));
    File('app/env/.env.$envName').writeAsStringSync(buf.toString());

    // Android flavor block
    bufferGradle.writeln('''
    create("$envName") {
        dimension = "default"
        applicationId = "$bundleId"
        resValue("string", "app_name", "$appName")
    }
''');
  });

  bufferGradle.writeln('}');

  _log('🛠️  Cập nhật Android build.gradle.kts tại: $androidGradlePath');
  _updateGradle(androidGradlePath, bufferGradle.toString());
  _ok('✅ Đã cập nhật flavors vào build.gradle.kts');

  _generateIosConfigs(environments: environments, iosDirPath: iosDirPath);
}

void _updateGradle(String path, String newFlavors) {
  final file = File(path);
  if (!file.existsSync()) {
    _err('Không tìm thấy $path');
    return;
  }
  final content = file.readAsStringSync();
  final pattern = RegExp(
    r'// FLAVOR-GEN-START[\s\S]*?// FLAVOR-GEN-END',
    multiLine: true,
  );
  final replacement =
  '''// FLAVOR-GEN-START
// DO NOT EDIT MANUALLY
$newFlavors
// FLAVOR-GEN-END''';

  final updated = content.contains(pattern)
      ? content.replaceFirst(pattern, replacement)
      : content.replaceFirst('android {', 'android {\n$replacement');
  file.writeAsStringSync(updated);
}

void _generateIosConfigs({
  required YamlMap environments,
  required String iosDirPath,
}) {
  final iosDir = Directory(iosDirPath);
  if (!iosDir.existsSync()) {
    _err('Không tìm thấy thư mục iOS tại $iosDirPath');
    return;
  }

  // Tạo/cập nhật các file setting (debug-<env>.yml, release-<env>.yml) và include trong base.yml
  _generateXcodegenSettingFiles(
    environments: environments,
    settingDirPath: '${iosDir.path}/xcodegen/setting',
  );

  // Cập nhật Podfile project mapping theo flavors
  _updatePodfileMappings(
    environments: environments,
    iosDirPath: iosDir.path,
  );

  // Cập nhật Flutter Debug.xcconfig và Release.xcconfig include theo flavors
  _updateFlutterXcconfigIncludes(
    environments: environments,
    iosDirPath: iosDir.path,
  );

  // Đọc template để lấy phần header tĩnh (trước 'configs:')
  final templatePath = '${iosDir.path}/xcodegen/project.template.yml';
  final templateFile = File(templatePath);
  if (!templateFile.existsSync()) {
    _err('Không tìm thấy template tại $templatePath');
    return;
  }
  final templateContent = templateFile.readAsStringSync();
  final lines = templateContent.split('\n');
  final headerBuffer = StringBuffer();
  for (final line in lines) {
    if (line.trim().startsWith('configs:')) break;
    headerBuffer.writeln(line);
  }

  // Tạo configs động
  final configsBuffer = StringBuffer();
  configsBuffer.writeln('configs:');
  environments.keys.forEach((envKey) {
    final env = envKey.toString();
    configsBuffer.writeln('  Debug-$env: Debug-$env');
    configsBuffer.writeln('  Release-$env: Release-$env');
  });

  // Tạo targets -> Runner
  final targetBuffer = StringBuffer();
  targetBuffer.writeln('targets:');
  targetBuffer.writeln('  Runner:');
  targetBuffer.writeln('    type: application');
  targetBuffer.writeln('    platform: iOS');
  targetBuffer.writeln('    configFiles:');
  environments.keys.forEach((envKey) {
    final env = envKey.toString();
    targetBuffer.writeln('      Debug-$env: Flutter/Debug.xcconfig');
    targetBuffer.writeln('      Release-$env: Flutter/Release.xcconfig');
  });
  targetBuffer.writeln('');
  targetBuffer.writeln('    sources:');
  targetBuffer.writeln('      #- GoogleService-Info.plist');
  targetBuffer.writeln('      - Flutter/AppFrameworkInfo.plist');
  targetBuffer.writeln('      - Flutter/Generated.xcconfig');
  targetBuffer.writeln('      - Flutter/Debug.xcconfig');
  targetBuffer.writeln('      - Flutter/Release.xcconfig');
  targetBuffer.writeln('      - path: Runner/');
  targetBuffer.writeln('');
  targetBuffer.writeln('    dependencies:');
  targetBuffer.writeln('      - sdk: Pods_Runner.framework');
  targetBuffer.writeln('        embed: false');
  targetBuffer.writeln('        link: true');
  targetBuffer.writeln('');
  targetBuffer.writeln('    preBuildScripts:');
  targetBuffer.writeln("      - name: '[CP] Check Pods Manifest.lock'");
  targetBuffer.writeln('        path: xcodegen/script/check_pods_manifest.sh');
  targetBuffer.writeln('        inputFiles:');
  targetBuffer.writeln(r'          - ${PODS_PODFILE_DIR_PATH}/Podfile.lock');
  targetBuffer.writeln(r'          - ${PODS_ROOT}/Manifest.lock');
  targetBuffer.writeln('        outputFiles:');
  targetBuffer.writeln(
    r'          - $(DERIVED_FILE_DIR)/Pods-Runner-checkManifestLockResult.txt',
  );
  targetBuffer.writeln('      - name: Run Script');
  targetBuffer.writeln('        path: xcodegen/script/run_script.sh');
  targetBuffer.writeln('');
  targetBuffer.writeln(
    '    # If you use different Firebase Project for each environment, you can use this script.',
  );
  targetBuffer.writeln("    # postCompileScripts:");
  targetBuffer.writeln('    #   - name: Select GoogleService-Info.plist');
  targetBuffer.writeln(
    '    #     path: xcodegen/script/select_google_service_info_plist.sh',
  );
  targetBuffer.writeln('    #     outputFiles:');
  targetBuffer.writeln(r'    #       - ${SRCROOT}/GoogleService-Info.plist');
  targetBuffer.writeln('');
  targetBuffer.writeln('    postBuildScripts:');
  targetBuffer.writeln('      - name: Thin Binary');
  targetBuffer.writeln('        path: xcodegen/script/thin_binary.sh');
  targetBuffer.writeln('        inputFiles:');
  targetBuffer.writeln(r'          - ${TARGET_BUILD_DIR}/${INFOPLIST_PATH}');
  targetBuffer.writeln('');
  targetBuffer.writeln('    settings:');
  targetBuffer.writeln('      base:');
  targetBuffer.writeln(
    '        ASSETCATALOG_COMPILER_INCLUDE_ALL_APPICON_ASSETS: NO',
  );
  targetBuffer.writeln('        CLANG_ENABLE_MODULES: YES');
  targetBuffer.writeln(
    r"        CURRENT_PROJECT_VERSION: '$(FLUTTER_BUILD_NUMBER)'",
  );
  targetBuffer.writeln('        # TODO: DEVELOPMENT_TEAM');
  targetBuffer.writeln('        # DEVELOPMENT_TEAM: YOUR_TEAM_ID');
  targetBuffer.writeln('        ENABLE_BITCODE: NO');
  targetBuffer.writeln('        INFOPLIST_FILE: Runner/Info.plist');
  targetBuffer.writeln(
    "        SWIFT_OBJC_BRIDGING_HEADER: 'Runner/Runner-Bridging-Header.h'",
  );
  targetBuffer.writeln('        SWIFT_VERSION: 5.0');
  targetBuffer.writeln("        VERSIONING_SYSTEM: 'apple-generic'");
  targetBuffer.writeln('      configs:');

  environments.forEach((envKey, values) {
    final env = envKey.toString();
    final cfg = (values as YamlMap?) ?? YamlMap();
    final bundleId = cfg['bundle_id']?.toString() ?? 'com.example.$env';
    final appName = cfg['app_name']?.toString() ?? env;
    final appIconName = 'AppIcon-$env';

    targetBuffer.writeln('        Release-$env:');
    targetBuffer.writeln(
      "          ASSETCATALOG_COMPILER_APPICON_NAME: '$appIconName'",
    );
    targetBuffer.writeln('          PRODUCT_BUNDLE_IDENTIFIER: $bundleId');
    targetBuffer.writeln("          PRODUCT_NAME: '$appName'");

    targetBuffer.writeln('        Debug-$env:');
    targetBuffer.writeln(
      "          ASSETCATALOG_COMPILER_APPICON_NAME: '$appIconName'",
    );
    targetBuffer.writeln('          PRODUCT_BUNDLE_IDENTIFIER: $bundleId');
    targetBuffer.writeln("          PRODUCT_NAME: '$appName'");
    targetBuffer.writeln("          SWIFT_OPTIMIZATION_LEVEL: '-Onone'");
  });

  // Schemes động
  final schemesBuffer = StringBuffer();
  schemesBuffer.writeln('schemes:');
  environments.keys.forEach((envKey) {
    final env = envKey.toString();
    schemesBuffer.writeln('  $env:');
    schemesBuffer.writeln('    build:');
    schemesBuffer.writeln('      targets:');
    schemesBuffer.writeln('        Runner: all');
    schemesBuffer.writeln('    run:');
    schemesBuffer.writeln('      config: Debug-$env');
    schemesBuffer.writeln('    test:');
    schemesBuffer.writeln('      config: Debug-$env');
    schemesBuffer.writeln('    profile:');
    schemesBuffer.writeln('      config: Release-$env');
    schemesBuffer.writeln('    analyze:');
    schemesBuffer.writeln('      config: Debug-$env');
    schemesBuffer.writeln('    archive:');
    schemesBuffer.writeln('      config: Release-$env');
  });

  final finalContent = StringBuffer()
    ..write(headerBuffer.toString())
    ..writeln(configsBuffer.toString())
    ..writeln(targetBuffer.toString())
    ..writeln(schemesBuffer.toString());

  final projectYml = File('${iosDir.path}/project.yml');
  projectYml.writeAsStringSync(finalContent.toString());
  _ok('📄 Đã tạo ${projectYml.path} động theo env_config.yaml');

  // xcodegen generate
  try {
    _log('⚙️  Chạy xcodegen generate trong ${iosDir.path}');
    final result = Process.runSync('xcodegen', [
      'generate',
    ], workingDirectory: iosDir.path);
    if (result.exitCode == 0) {
      _ok('🎉 Xcode project đã generate thành công');
    } else {
      _warn('xcodegen lỗi: ${result.stderr}');
    }
  } catch (e) {
    _warn('Không thể chạy xcodegen: $e');
  }
}

void _updatePodfileMappings({
  required YamlMap environments,
  required String iosDirPath,
}) {
  final podfile = File('$iosDirPath/Podfile');
  if (!podfile.existsSync()) {
    _warn('Không tìm thấy Podfile để cập nhật mapping.');
    return;
  }
  var content = podfile.readAsStringSync();

  // Tạo block mapping mới
  final buffer = StringBuffer();
  buffer.writeln("project 'Runner', {");
  environments.keys.forEach((envKey) {
    final env = envKey.toString();
    buffer.writeln("  'Debug-$env' => :debug,");
    buffer.writeln("  'Release-$env' => :release,");
  });
  buffer.write('}');

  final pattern = RegExp(r"project 'Runner', \{[\s\S]*?\}", multiLine: true);
  if (pattern.hasMatch(content)) {
    content = content.replaceFirst(pattern, buffer.toString());
  } else {
    // Nếu không tìm thấy, chèn sau dòng flutter_ios_podfile_setup hoặc đầu file như fallback
    final anchor = RegExp(r'^flutter_ios_podfile_setup$', multiLine: true);
    if (anchor.hasMatch(content)) {
      content = content.replaceFirst(
        anchor,
        'flutter_ios_podfile_setup\n\n${buffer.toString()}',
      );
    } else {
      content = buffer.toString() + '\n\n' + content;
    }
  }
  podfile.writeAsStringSync(content);
  _ok('✅ Đã cập nhật Podfile mappings theo flavors');
}

void _updateFlutterXcconfigIncludes({
  required YamlMap environments,
  required String iosDirPath,
}) {
  final debugFile = File('$iosDirPath/Flutter/Debug.xcconfig');
  final releaseFile = File('$iosDirPath/Flutter/Release.xcconfig');
  if (!debugFile.existsSync() || !releaseFile.existsSync()) {
    _warn('Thiếu Flutter/Debug.xcconfig hoặc Release.xcconfig, bỏ qua cập nhật include.');
    return;
  }

  // Build include lines theo env
  final debugIncludes = StringBuffer();
  environments.keys.forEach((envKey) {
    final env = envKey.toString();
    debugIncludes.writeln('#include? "Pods/Target Support Files/Pods-Runner/Pods-Runner.debug-$env.xcconfig"');
  });
  final releaseIncludes = StringBuffer();
  environments.keys.forEach((envKey) {
    final env = envKey.toString();
    releaseIncludes.writeln('#include? "Pods/Target Support Files/Pods-Runner/Pods-Runner.release-$env.xcconfig"');
  });

  // Hàm cập nhật nội dung file xcconfig giữ #include "Generated.xcconfig" ở cuối
  String _composeXcconfig(String existing, String dynamicLines) {
    final genLine = '#include "Generated.xcconfig"';
    if (existing.contains(genLine)) {
      return dynamicLines + '\n' + genLine + '\n';
    }
    return dynamicLines + '\n';
  }

  final newDebug = _composeXcconfig(debugFile.readAsStringSync(), debugIncludes.toString().trim());
  final newRelease = _composeXcconfig(releaseFile.readAsStringSync(), releaseIncludes.toString().trim());

  debugFile.writeAsStringSync(newDebug);
  releaseFile.writeAsStringSync(newRelease);
  _ok('✅ Đã cập nhật Flutter Debug/Release.xcconfig includes theo flavors');
}

void _generateXcodegenSettingFiles({
  required YamlMap environments,
  required String settingDirPath,
}) {
  final settingDir = Directory(settingDirPath);
  if (!settingDir.existsSync()) {
    settingDir.createSync(recursive: true);
    _ok('📁 Đã tạo thư mục ${settingDir.path}');
  }

  // Lấy danh sách tất cả các file yml hiện tại trong thư mục
  final currentFiles = settingDir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.yml'))
      .where((f) => !f.path.endsWith('base.yml'))
      .toList();

  // Tập hợp các file cần giữ lại
  final Set<String> requiredFiles = {};

  // Tạo hoặc cập nhật file debug-<env>.yml và release-<env>.yml cho mỗi environment
  environments.forEach((envKey, values) {
    final env = envKey.toString();
    final cfg = (values as YamlMap?) ?? YamlMap();
    final appName = cfg['app_name']?.toString() ?? env.toUpperCase();

    // Thêm vào danh sách file cần giữ lại
    final debugPath = '$settingDirPath/debug-$env.yml';
    final releasePath = '$settingDirPath/release-$env.yml';
    requiredFiles.add(debugPath);
    requiredFiles.add(releasePath);

    // Luôn tạo mới file debug
    final debugContent = '''settings:
  configs:
    Debug-$env:
      APP_NAME: '$appName'
      DEBUG_INFORMATION_FORMAT: 'dwarf'
      ENABLE_TESTABILITY: YES
      GCC_DYNAMIC_NO_PIC: NO
      GCC_OPTIMIZATION_LEVEL: 0
      GCC_PREPROCESSOR_DEFINITIONS: [
          "DEBUG=1",
          "\$(inherited)",
      ]
      IPHONEOS_DEPLOYMENT_TARGET: 16.0
      MTL_ENABLE_DEBUG_INFO: YES
      ONLY_ACTIVE_ARCH: YES
      PRODUCT_NAME: '$appName'
''';
    File(debugPath).writeAsStringSync(debugContent);
    _ok('✨ Đã cập nhật $debugPath');

    // Luôn tạo mới file release
    final releaseContent = '''settings:
  configs:
    Release-$env:
      APP_NAME: $appName
      DEBUG_INFORMATION_FORMAT: "dwarf-with-dsym"
      ENABLE_NS_ASSERTIONS: NO
      IPHONEOS_DEPLOYMENT_TARGET: 16.0
      MTL_ENABLE_DEBUG_INFO: NO
      SUPPORTED_PLATFORMS: iphoneos
      SWIFT_COMPILATION_MODE: wholemodule
      SWIFT_OPTIMIZATION_LEVEL: "-O"
      VALIDATE_PRODUCT: YES
''';
    File(releasePath).writeAsStringSync(releaseContent);
    _ok('✨ Đã cập nhật $releasePath');
  });

  // Xóa các file không còn được sử dụng
  for (final file in currentFiles) {
    if (!requiredFiles.contains(file.path)) {
      file.deleteSync();
      _ok('🗑️ Đã xóa ${file.path} vì không còn được sử dụng');
    }
  }

  // Cập nhật base.yml với danh sách includes mới
  final baseFile = File('$settingDirPath/base.yml');
  if (!baseFile.existsSync()) {
    _warn('Thiếu base.yml tại $settingDirPath, bỏ qua cập nhật include.');
    return;
  }

  // Tạo nội dung includes mới với markers
  final includesContent = environments.keys.map((envKey) {
    final env = envKey.toString();
    return "  - path: './debug-$env.yml'\n    relativePath: true\n  - path: './release-$env.yml'\n    relativePath: true";
  }).join('\n');

  // Đọc nội dung base.yml hiện tại
  var baseContent = baseFile.readAsStringSync();

  // Tìm vị trí bắt đầu và kết thúc block INCLUDES
  final startMarker = '# INCLUDES START';
  final endMarker = '# INCLUDES END';
  final startIdx = baseContent.indexOf(startMarker);
  final endIdx = baseContent.indexOf(endMarker);

  final newIncludesBlock = '$startMarker\ninclude:\n$includesContent\n$endMarker';

  if (startIdx != -1 && endIdx != -1 && endIdx > startIdx) {
    // Thay thế block includes cũ bằng block mới
    final before = baseContent.substring(0, startIdx);
    // endIdx + endMarker.length lấy hết marker
    final after = baseContent.substring(endIdx + endMarker.length);
    baseContent = before + newIncludesBlock + after;
  } else {
    // Nếu chưa có markers, thêm vào đầu file
    baseContent = newIncludesBlock + baseContent;
  }

  baseFile.writeAsStringSync(baseContent);
}

String _resolvePath(List<String> candidates) {
  for (final c in candidates) {
    final f = File(c);
    if (f.existsSync()) return f.path;
    final d = Directory(c);
    if (d.existsSync()) return d.path;
  }
  return candidates.first;
}

void _log(String msg) => stdout.writeln(msg);

void _ok(String msg) => stdout.writeln(msg);

void _warn(String msg) => stdout.writeln(msg);

void _err(String msg) => stderr.writeln(msg);
