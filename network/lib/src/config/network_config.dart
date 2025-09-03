import 'package:network/src/di/di.dart' as di;
import 'package:shared/shared.dart';

class NetworkConfig extends Config {
  NetworkConfig._();

  factory NetworkConfig.getInstance() {
    return _instance;
  }

  static final NetworkConfig _instance = NetworkConfig._();

  @override
  Future<void> config() async => di.configureInjection();
}
