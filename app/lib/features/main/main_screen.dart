import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../blocs/base/base_screen_state.dart';
import '../../blocs/main/main_cubit.dart';
import '../../blocs/main/main_state.dart';
import '../../navigation/navigation.dart';
import '../../resource/resource.dart';
import 'components/app_bottom_navigation_bar.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends BaseScreenState<MainScreen, MainCubit> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final double heightBottomNavigationBar = 71 + (context.padding.bottom > 0 ? (context.padding.bottom / 2) : 0);
      bloc.setHeightBottomNavigationBar(heightBottomNavigationBar);
    });
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      buildWhen: (pre, cur) => pre.indexBottomTab != cur.indexBottomTab,
      builder: (context, state) {
        return AutoTabsScaffold(
          routes: [
            const HomeTab(),
            const CalendarTab(),
            const MessageTab(),
            const SettingTab(),
          ],
          bottomNavigationBuilder: (context, tabsRouter) {
            (navigator as AppNavigatorImpl).tabsRouter = tabsRouter;

            return AppBottomNavigationBar(
              onTap: (index) {
                tabsRouter.setActiveIndex(index);
                bloc.setIndexBottomTab(index);
              },
            );
          },
        );
      },
    );
  }
}

enum BottomTab {
  home,
  calendar,
  message,
  setting;

  String get title {
    switch (this) {
      case BottomTab.home:
        return S.current.trangChu;
      case BottomTab.calendar:
        return S.current.lich;
      case BottomTab.message:
        return S.current.tinNhan;
      case BottomTab.setting:
        return S.current.caiDat;
    }
  }

  String get icon {
    switch (this) {
      case BottomTab.home:
        return Assets.icons.icBottomHome;
      case BottomTab.calendar:
        return Assets.icons.icBottomCalendar;
      case BottomTab.message:
        return Assets.icons.icBottomMessage;
      case BottomTab.setting:
        return Assets.icons.icBottomSetting;
    }
  }
}
