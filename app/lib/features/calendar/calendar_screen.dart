import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../blocs/base/base_screen_state.dart';
import '../../blocs/calendar/calendar_cubit.dart';
import '../../blocs/calendar/calendar_state.dart';
import '../../blocs/main/main_cubit.dart';
import '../../blocs/main/main_state.dart';
import '../../navigation/navigation.dart';
import '../../navigation/router/app_router.gr.dart';
import '../../resource/resource.dart';
import '../../theme/theme.dart';
import 'components/calendar_year_view.dart';

@RoutePage()
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends BaseScreenState<CalendarScreen, CalendarCubit> {
  final _mainCubit = GetIt.instance.get<MainCubit>();

  late final ScrollController _scrollController;

  static const int _startYear = 1975;
  static const int _endYear = 2100;
  static const int _currentYear = 2025;

  double _yearHeight = 800;
  int _displayedYear = _currentYear;

  @override
  void initState() {
    super.initState();

    _initializeControllers();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateYearHeight();
      _performInitialScroll();
    });
  }

  void _initializeControllers() {
    _scrollController = ScrollController();
    _scrollController.addListener(_updateCurrentYear);
  }

  void _calculateYearHeight() {
    if (!mounted) {
      return;
    }

    final newHeight =
        context.screenHeight -
        UiConstants.appBarCalendarHeight -
        context.statusBarHeight -
        _mainCubit.state.heightBottomNavigationBar;

    if (newHeight != _yearHeight) {
      setState(() {
        _yearHeight = newHeight;
      });
    }
  }

  void _performInitialScroll() {
    if (!mounted) {
      return;
    }

    if (bloc.state.calendarViewMode == CalendarViewMode.year) {
      _scrollToCurrentYear();
    }
  }

  void _scrollToCurrentYear() {
    // Kiểm tra xem controller đã được attach chưa
    if (!_scrollController.hasClients) {
      // Nếu chưa được attach, delay việc scroll
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _scrollController.hasClients) {
          _scrollToCurrentYearImmediate();
        }
      });
      return;
    }
    _scrollToCurrentYearImmediate();
  }

  void _scrollToCurrentYearImmediate() {
    final initialOffset = (_displayedYear - _startYear) * _yearHeight;

    // Đảm bảo offset không vượt quá giới hạn
    final maxOffset = _scrollController.position.maxScrollExtent;
    final targetOffset = initialOffset.clamp(0.0, maxOffset);

    try {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(targetOffset);
      }
    } catch (e) {
      // Fallback: sử dụng animateTo thay vì jumpTo
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          targetOffset,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _updateCurrentYear() {
    if (!_scrollController.hasClients) {
      return;
    }

    final offset = _scrollController.offset;
    final newYear = _startYear + (offset / _yearHeight).round();

    if (newYear != _displayedYear && newYear >= _startYear && newYear <= _endYear) {
      setState(() {
        _displayedYear = newYear;
      });
    }
  }

  Future<void> _handleViewModeChange(CalendarViewMode newMode) async {
    final stack = context.router.stack.map((e) => e.name).toList();
    logD('Current navigation CalendarTab stack: $stack');

    switch (newMode) {
      case CalendarViewMode.year:
        context.router.popUntilRoot();
        return;
      case CalendarViewMode.month:
        if (stack.contains(CalendarMonthView.name)) {
          // Nếu có Week trên stack thì pop về Month
          context.router.popUntilRouteWithName(CalendarMonthView.name);
        } else {
          // Nếu chỉ có Year thì push Month
          await context.router.push(
            CalendarMonthView(year: bloc.state.focusedDate?.year, month: bloc.state.focusedDate?.month),
          );
        }
        return;
      case CalendarViewMode.week:
        if (stack.contains(CalendarWeekView.name)) {
          // Đã ở Week rồi thì thôi
          return;
        } else if (stack.contains(CalendarMonthView.name)) {
          // Có B rồi thì push C
          await context.router.push(
            CalendarWeekView(
              weekIndex: bloc.state.week!,
              year: bloc.state.focusedDate?.year,
              month: bloc.state.focusedDate?.month,
            ),
          );
        } else {
          // Chưa có Month → push Month rồi push Week
          await context.router.pushAll([
            CalendarMonthView(year: bloc.state.focusedDate?.year, month: bloc.state.focusedDate?.month),
            CalendarWeekView(
              weekIndex: bloc.state.week!,
              year: bloc.state.focusedDate?.year,
              month: bloc.state.focusedDate?.month,
            ),
          ]);
        }
        return;
        // Navigator.of(context).push(
        //   PageRouteBuilder(
        //     pageBuilder: (context, animation, secondaryAnimation) =>
        //         CalendarWeekView(weekIndex: bloc.state.week!, year: bloc.state.year, month: bloc.state.month),
        //     transitionDuration: const Duration(milliseconds: 500),
        //     reverseTransitionDuration: const Duration(milliseconds: 500),
        //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
        //       return FadeTransition(opacity: animation, child: child);
        //     },
        //   ),
        // );
        break;
    }
  }

  void _onMonthTap(BuildContext context, int year, int month, Rect itemRect) {
    logD('On month tap: $month-$year');
    bloc.onSetCalendarViewModeMonth(DateTime(year, month));
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.bgBrand,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverList.builder(
            itemCount: _endYear - _startYear + 1,
            itemBuilder: (context, index) {
              final year = _startYear + index;
              return SizedBox(
                height: _yearHeight,
                child: CalendarYearView(
                  key: ValueKey('year_$year'),
                  year: year,
                  onMonthTap: (month, rect) => _onMonthTap(context, year, month, rect),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget buildPageListeners({required Widget child}) {
    return BlocProvider<MainCubit>(
      create: (context) => _mainCubit,
      child: MultiBlocListener(
        listeners: [
          BlocListener<CalendarCubit, CalendarState>(
            listenWhen: (previous, current) => previous.calendarViewMode != current.calendarViewMode,
            listener: (context, state) {
              _handleViewModeChange(state.calendarViewMode);
            },
          ),
          BlocListener<MainCubit, MainState>(
            listenWhen: (previous, current) => previous.heightBottomNavigationBar != current.heightBottomNavigationBar,
            listener: (context, state) {
              _calculateYearHeight();
            },
          ),
        ],
        child: child,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

enum CalendarViewMode {
  year,
  month,
  week;

  String get title {
    switch (this) {
      case CalendarViewMode.year:
        return S.current.year;
      case CalendarViewMode.month:
        return S.current.thang;
      case CalendarViewMode.week:
        return S.current.tuan;
    }
  }

  String get icon {
    switch (this) {
      case CalendarViewMode.year:
        return Assets.icons.icCalendarPopupYear;
      case CalendarViewMode.month:
        return Assets.icons.icCalendarPopupMonth;
      case CalendarViewMode.week:
        return Assets.icons.icCalendarPopupWeek;
    }
  }
}
