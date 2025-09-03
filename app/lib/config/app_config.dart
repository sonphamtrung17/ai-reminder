import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network/network.dart';
import 'package:shared/shared.dart';

import '../blocs/base/app_bloc_observer.dart';
import '../di/di.dart' as di;

class AppConfig extends Config {
  factory AppConfig.getInstance() {
    return _instance;
  }

  AppConfig._();

  static final AppConfig _instance = AppConfig._();

  @override
  Future<void> config() async {
    di.configureInjection();
    Bloc.observer = const AppBlocObserver();
    await ViewUtils.setPreferredOrientations(
      DeviceUtils.deviceType == DeviceType.mobile
          ? UiConstants.mobileOrientation
          : UiConstants.tabletOrientation,
    );
    ViewUtils.setSystemUIOverlayStyle(UiConstants.systemUiOverlay);
  }
}

class AppInitializer {
  AppInitializer(this._applicationConfig);

  final Config _applicationConfig;

  Future<void> init() async {
    await EnvConstants.init();
    await SharedConfig.getInstance().init();
    await NetworkConfig.getInstance().init();
    await _applicationConfig.init();
  }
}
