import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../router/app_router.gr.dart';

@LazySingleton()
class IntroGuard extends AutoRouteGuard {
  final AppPreferences _appPreferences;

  IntroGuard(this._appPreferences);

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (_appPreferences.isFirstLaunchApp) {
      await router.push(const IntroScreen());
    } else {
      resolver.next();
    }
  }
}
