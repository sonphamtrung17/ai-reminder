import 'package:flutter/services.dart';
import 'package:shared/shared.dart';

class EnvConstants {
  const EnvConstants._();

  static const flavorKey = 'FLAVOR';

  static String flavor = const String.fromEnvironment(
    flavorKey,
    defaultValue: 'dev',
  );
  static Map<String, String> envValues = {};

  static Future<void> init() async {
    Log.d(flavor, name: flavorKey);
    envValues = await _loadEnv('env/.env.$flavor');
    Log.d(envValues, name: 'EnvValues');
  }

  static Future<Map<String, String>> _loadEnv(String assetPath) async {
    final content = await rootBundle.loadString(assetPath);
    final env = <String, String>{};
    for (var line in content.split('\n')) {
      line = line.trim();
      if (line.isEmpty || line.startsWith('#')) continue;
      final index = line.indexOf('=');
      if (index == -1) continue;
      final key = line.substring(0, index).trim();
      final value = line.substring(index + 1).trim();
      env[key] = value;
    }
    return env;
  }
}
