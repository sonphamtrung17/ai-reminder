import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../blocs/app/app_cubit.dart';
import '../../blocs/app/app_state.dart';
import '../../components/components.dart';
import '../../resource/resource.dart';
import '../calendar/calendar_tab.dart';
import '../home/home_tab.dart';
import '../message/message_tab.dart';
import '../setting/setting_tab.dart';
import 'components/app_bottom_navigation_bar.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _appCubit = GetIt.instance.get<AppCubit>();

  @override
  Widget build(BuildContext context) {
    final double heightBottomNavigationBar = 71 + (context.padding.bottom > 0 ? (context.padding.bottom / 2) : 0);

    return BlocProvider<AppCubit>(
      create: (context) => _appCubit,
      child: BlocBuilder<AppCubit, AppState>(
        buildWhen: (pre, cur) => pre.indexBottomTab != cur.indexBottomTab,
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                IndexedStack(
                  index: state.indexBottomTab,
                  children: [
                    const HomeTab(),
                    const CalendarTab(),
                    const MessageTab(),
                    const SettingTab(),
                  ],
                ),
                Visibility(
                  visible: state.indexBottomTab == 0,
                  child: Positioned(
                    bottom: heightBottomNavigationBar + 24,
                    right: 16,
                    child: AppButton.icon(
                      iconPath: Assets.icons.icHomeAdd,
                      onPressed: () {},
                      padding: const EdgeInsets.all(10),
                      iconWidth: 32,
                      iconHeight: 32,
                      iconColor: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: AppBottomNavigationBar(height: heightBottomNavigationBar),
                ),
              ],
            ),
          );
        },
      ),
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
