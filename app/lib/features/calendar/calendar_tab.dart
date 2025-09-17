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

  // Overlay variables for animation
  OverlayEntry? _overlayEntry;
  int? _selectedYear;
  int? _selectedMonth;

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

    // Implement transition logic if needed
  }

  void _showMonthDetail(BuildContext context, int year, int month, Rect itemRect) {
    // Set selected month and year for the month view
    _selectedYear = year;
    _selectedMonth = month;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return AnimatedMonthOverlay(
          year: year,
          month: month,
          startRect: itemRect,
          heightBottomNavigationBar: widget.heightBottomNavigationBar,
          onClose: () {
            _overlayEntry?.remove();
            _overlayEntry = null;
            _selectedYear = null;
            _selectedMonth = null;
          },
          onSwitchToMonthView: () {
            // Switch to actual month view mode
            bloc.setCalendarViewMode(CalendarViewMode.month);
            _overlayEntry?.remove();
            _overlayEntry = null;
          },
        );
      },
    );

    Overlay.of(context, debugRequiredFor: widget)?.insert(_overlayEntry!);
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
                onMonthTap: (month, rect) => _showMonthDetail(context, year, month, rect),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMonthView() {
    return CalendarMonthView(
      year: _selectedYear,
      month: _selectedMonth,
    );
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
          body: body,
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
    _overlayEntry?.remove();
    _scrollController.dispose();

    // Dispose cached controllers
    for (final controller in _scrollControllers.values) {
      controller.dispose();
    }
    _scrollControllers.clear();

    super.dispose();
  }
}

/// Widget overlay animating from a month widget to fullscreen month view
class AnimatedMonthOverlay extends StatefulWidget {
  final int year;
  final int month;
  final Rect startRect;
  final double heightBottomNavigationBar;
  final VoidCallback onClose;
  final VoidCallback onSwitchToMonthView;

  const AnimatedMonthOverlay({
    super.key,
    required this.year,
    required this.month,
    required this.startRect,
    required this.heightBottomNavigationBar,
    required this.onClose,
    required this.onSwitchToMonthView,
  });

  @override
  State<AnimatedMonthOverlay> createState() => _AnimatedMonthOverlayState();
}

class _AnimatedMonthOverlayState extends State<AnimatedMonthOverlay> with TickerProviderStateMixin {
  late AnimationController _expansionController;
  late AnimationController _contentController;

  late Animation<Rect?> _rectAnimation;
  late Animation<double> _borderRadiusAnimation;
  late Animation<double> _contentOpacityAnimation;
  late Animation<double> _backgroundOpacityAnimation;

  @override
  void initState() {
    super.initState();

    // Main expansion controller
    _expansionController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    // Content fade controller (delayed)
    _contentController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenSize = MediaQuery.of(context).size;
      final statusBarHeight = MediaQuery.of(context).padding.top;
      final endRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);

      // Rect animation with custom curve
      _rectAnimation =
          RectTween(
            begin: widget.startRect,
            end: endRect,
          ).animate(
            CurvedAnimation(
              parent: _expansionController,
              curve: const Cubic(0.25, 0.46, 0.45, 0.94), // iOS-like easing
            ),
          );

      // Border radius animation
      _borderRadiusAnimation =
          Tween<double>(
            begin: 8.0,
            end: 0.0,
          ).animate(
            CurvedAnimation(
              parent: _expansionController,
              curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
            ),
          );

      // Background overlay
      _backgroundOpacityAnimation =
          Tween<double>(
            begin: 0.0,
            end: 0.3,
          ).animate(
            CurvedAnimation(
              parent: _expansionController,
              curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
            ),
          );

      // Content opacity (delayed until expansion is mostly complete)
      _contentOpacityAnimation =
          Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: _contentController,
              curve: Curves.easeIn,
            ),
          );

      // Start the animation sequence
      _startAnimation();
    });
  }

  void _startAnimation() async {
    // Start expansion
    await _expansionController.forward();

    // Once expansion is complete, fade in content
    await _contentController.forward();

    // Auto-switch to month view after animation completes
    await Future.delayed(const Duration(milliseconds: 100));
    widget.onSwitchToMonthView();
  }

  void _close() async {
    // Fade out content first
    await _contentController.reverse();

    // Then reverse expansion
    await _expansionController.reverse();

    widget.onClose();
  }

  @override
  void dispose() {
    _expansionController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: Listenable.merge([_expansionController, _contentController]),
        builder: (context, child) {
          final rect = _rectAnimation.value!;
          final isExpanding = _expansionController.isAnimating;
          final showContent = _expansionController.value > 0.85;

          return Stack(
            children: [
              // Semi-transparent background
              if (_expansionController.value > 0.2)
                Opacity(
                  opacity: _backgroundOpacityAnimation.value,
                  child: Container(
                    color: Colors.black,
                  ),
                ),

              // Main animated container
              Positioned(
                left: rect.left,
                top: rect.top,
                width: rect.width,
                height: rect.height,
                child: Material(
                  borderRadius: BorderRadius.circular(_borderRadiusAnimation.value),
                  color: context.color.bgBrand,
                  elevation: _expansionController.value * 10,
                  shadowColor: Colors.black.withOpacity(0.3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(_borderRadiusAnimation.value),
                    child: showContent
                        ? AnimatedBuilder(
                            animation: _contentController,
                            builder: (context, child) {
                              return Opacity(
                                opacity: _contentOpacityAnimation.value,
                                child: Column(
                                  children: [
                                    // App Bar with back button
                                    SafeArea(
                                      bottom: false,
                                      child: Container(
                                        height: 56,
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        decoration: BoxDecoration(
                                          color: context.color.bgBrand,
                                          border: Border(
                                            bottom: BorderSide(
                                              color: context.color.border.withOpacity(0.3),
                                              width: 0.5,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: _close,
                                              icon: Icon(
                                                Icons.arrow_back_ios,
                                                size: 20,
                                                color: context.color.primary,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Tháng ${widget.month} ${widget.year}',
                                                style: context.textStyle.headingMSemiBold,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            const SizedBox(width: 48),
                                            // Balance the back button
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Month View Content
                                    Expanded(
                                      child: CalendarMonthView(
                                        year: widget.year,
                                        month: widget.month,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: context.color.bgBrand,
                              borderRadius: BorderRadius.circular(_borderRadiusAnimation.value),
                            ),
                            child: Center(
                              child: Transform.scale(
                                scale: 1.0 + (_expansionController.value * 0.2),
                                // Slight scale effect
                                child: Text(
                                  CalendarConstants.monthNames[widget.month - 1],
                                  style: context.textStyle.bodyLSemiBold.copyWith(
                                    fontSize: 14 + (8 * _expansionController.value),
                                    color: context.color.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
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
