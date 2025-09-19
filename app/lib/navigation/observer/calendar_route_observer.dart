import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../blocs/calendar/calendar_cubit.dart';

class CalendarRouteObserver extends AutoRouterObserver {
  final _calendarCubit = GetIt.instance.get<CalendarCubit>();
  final _enableLog = kDebugMode;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _calendarCubit.checkCurrentRoute();
    if (_enableLog) {
      debugPrint('📌 CalendarTab didPush → ${route.settings.name}');
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _calendarCubit.checkCurrentRoute();
    if (_enableLog) {
      debugPrint('👈 CalendarTab didPop → ${route.settings.name}');
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _calendarCubit.checkCurrentRoute();
    if (_enableLog) {
      debugPrint('🔄 CalendarTab didRemove → ${previousRoute?.settings.name} → ${route.settings.name}');
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (_enableLog) {
      debugPrint('🔄 CalendarTab didReplace → ${oldRoute?.settings.name} → ${newRoute?.settings.name}');
    }
  }
}
