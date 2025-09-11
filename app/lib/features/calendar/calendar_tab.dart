import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../blocs/base/base_screen_state.dart';
import '../../blocs/calendar/calendar_cubit.dart';
import '../../blocs/calendar/calendar_state.dart';
import '../../resource/resource.dart';
import '../../theme/theme.dart';
import 'components/app_bar_calendar.dart';
import 'components/calendar_month_view.dart';
import 'components/calendar_year_view.dart';

class CalendarTab extends StatefulWidget {
  final double heightBottomNavigationBar;

  const CalendarTab({required this.heightBottomNavigationBar, super.key});

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends BaseScreenState<CalendarTab, CalendarCubit> with TickerProviderStateMixin {
  late final ScrollController _scrollController;

  static const int _startYear = 1975;
  static const int _endYear = 2100;
  static const int _currentYear = 2025;

  double _yearHeight = 800;
  int _displayedYear = _currentYear;

  // Cache cho các controller để tránh tạo mới liên tục
  // Cache for smooth transitions
  final Map<String, GlobalKey> _monthKeys = {};
  final Map<CalendarViewMode, ScrollController> _scrollControllers = {};

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
        widget.heightBottomNavigationBar;

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

  void _handleViewModeChange(CalendarViewMode newMode) {
    if (!mounted) {
      return;
    }

    // switch (newMode) {
    //   case CalendarViewMode.year:
    //     _animateToYearView();
    //     break;
    //   case CalendarViewMode.month:
    //     _animateToMonthView();
    //     break;
    //   case CalendarViewMode.week:
    //     _animateToWeekView();
    //     break;
    // }
  }

  Widget _buildYearView() {
    return CustomScrollView(
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
                onMonthTap: (month) => _onMonthTapped(year, month),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMonthView() {
    return const CalendarMonthView();
  }

  void _onMonthTapped(int year, int month) {
    print('Month tapped: $month/$year');
  }

  Widget _buildWeekView() {
    return Container(
      padding: EdgeInsets.only(bottom: widget.heightBottomNavigationBar),
      child: Center(
        child: Text(
          'Week View for $_displayedYear',
          style: context.textStyle.headingLMedium,
        ),
      ),
    );
  }

  // String get _displayTitle {
  //   switch (bloc.state.calendarViewMode) {
  //     case CalendarViewMode.year:
  //       return '$_displayedYear';
  //     case CalendarViewMode.month:
  //       return 'Tháng $_displayedMonth, $_displayedYear';
  //     case CalendarViewMode.week:
  //       return 'Tuần $_displayedYear';
  //   }
  // }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        Widget body;
        switch (state.calendarViewMode) {
          case CalendarViewMode.year:
            body = _buildYearView();
          case CalendarViewMode.month:
            body = _buildMonthView();
          case CalendarViewMode.week:
            body = _buildWeekView();
        }

        return Scaffold(
          backgroundColor: context.color.bgBrand,
          appBar: AppBarCalendar(title: '$_displayedYear'),
          body: body.wrapPadding(EdgeInsetsGeometry.only(bottom: widget.heightBottomNavigationBar)),
        );
      },
    );
  }

  @override
  Widget buildPageListeners({required Widget child}) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CalendarCubit, CalendarState>(
          listenWhen: (previous, current) => previous.calendarViewMode != current.calendarViewMode,
          listener: (context, state) {
            _handleViewModeChange(state.calendarViewMode);
          },
        ),
      ],
      child: child,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();

    // Dispose cached controllers
    for (final controller in _scrollControllers.values) {
      controller.dispose();
    }
    _scrollControllers.clear();

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
        return S.current.nam;
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
