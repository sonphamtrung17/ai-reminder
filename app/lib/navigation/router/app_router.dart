import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import '../navigation.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
@LazySingleton()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashScreen.page),
    AutoRoute(
      page: MainScreen.page,
      initial: true,
      children: [
        AutoRoute(
          page: HomeTab.page,
          initial: true,
          maintainState: true,
          children: [
            AutoRoute(page: HomeScreen.page, initial: true),
          ],
        ),
        AutoRoute(
          page: CalendarTab.page,
          maintainState: true,
          children: [
            AutoRoute(page: CalendarScreen.page, initial: true),
            AutoRoute(page: CalendarMonthView.page),
            AutoRoute(page: CalendarWeekView.page),
          ],
        ),
        AutoRoute(
          page: MessageTab.page,
          maintainState: true,
          children: [
            AutoRoute(page: MessageScreen.page, initial: true),
          ],
        ),
        AutoRoute(
          page: SettingTab.page,
          maintainState: true,
          children: [
            AutoRoute(page: SettingScreen.page, initial: true),
          ],
        ),
      ],
    ),
    AutoRoute(page: ListInterestScreen.page),
    AutoRoute(page: CreateInterestScreen.page),
    AutoRoute(page: ListEventScreen.page),
    AutoRoute(page: NotificationScreen.page),
  ];
}

@RoutePage(name: 'HomeTab')
class HomeTabPage extends AutoRouter {
  const HomeTabPage({super.key});
}

@RoutePage(name: 'CalendarTab')
class CalendarTabPage extends AutoRouter {
  const CalendarTabPage({super.key});
}

@RoutePage(name: 'MessageTab')
class MessageTabPage extends AutoRouter {
  const MessageTabPage({super.key});
}

@RoutePage(name: 'SettingTab')
class SettingTabPage extends AutoRouter {
  const SettingTabPage({super.key});
}

extension RouterX on StackRouter {
  StackRouter? get calendarTab => root.innerRouterOf<StackRouter>(CalendarTab.name);
}
