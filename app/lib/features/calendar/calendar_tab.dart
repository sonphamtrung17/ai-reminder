import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../blocs/base/base_screen_state.dart';
import '../../blocs/calendar/calendar_cubit.dart';
import '../../components/components.dart';
import '../../resource/resource.dart';
import '../../theme/theme.dart';
import 'components/app_bar_calendar.dart';

class CalendarTab extends StatefulWidget {
  final double heightBottomNavigationBar;

  const CalendarTab({required this.heightBottomNavigationBar, super.key});

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends BaseScreenState<CalendarTab, CalendarCubit> {
  final _scrollController = ScrollController();

  final int _startYear = 1975;
  final int _endYear = 2100;

  int _currentYear = 2025;
  double _yearHeight = 800;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _yearHeight =
              context.screenHeight -
              UiConstants.appBarCalendarHeight -
              context.statusBarHeight -
              widget.heightBottomNavigationBar;
        });
      }
    });

    _scrollController.addListener(_updateCurrentYear);

    // Scroll to current year after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final initialOffset = (_currentYear - _startYear) * _yearHeight;
      _scrollController.jumpTo(initialOffset);
    });
  }

  void _updateCurrentYear() {
    if (_scrollController.hasClients) {
      final offset = _scrollController.offset;
      final newYear = _startYear + (offset / _yearHeight).round();
      if (newYear != _currentYear && newYear >= _startYear && newYear <= _endYear) {
        setState(() {
          _currentYear = newYear;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.bgBrand,
      appBar: AppBarCalendar(title: '$_currentYear'),
      body: CustomScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverList.builder(
            itemCount: _endYear - _startYear + 1,
            itemBuilder: (context, index) {
              final year = _startYear + index;
              return SizedBox(
                height: _yearHeight,
                child: YearView(year: year),
              );
            },
          ),
        ],
      ).wrapPadding(EdgeInsets.only(bottom: widget.heightBottomNavigationBar)),
    );
  }
}

class YearView extends StatefulWidget {
  final int year;

  const YearView({required this.year, super.key});

  @override
  State<YearView> createState() => _YearViewState();
}

class _YearViewState extends State<YearView> with AutomaticKeepAliveClientMixin {
  List<MonthWidget>? _monthWidgets;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // Build months lazily
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _monthWidgets = List.generate(12, (index) {
            return MonthWidget(year: widget.year, month: index + 1);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0.0),
      child: _monthWidgets == null
          ? Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]!),
                ),
              ),
            )
          : GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 95 / 120,
              padding: EdgeInsets.zero,
              crossAxisSpacing: 14,
              mainAxisSpacing: 35,
              children: _monthWidgets!,
            ),
    );
  }
}

class MonthWidget extends StatelessWidget {
  final int year;
  final int month;

  const MonthWidget({required this.year, required this.month, super.key});

  static const List<String> _monthNames = [
    'Tháng 1',
    'Tháng 2',
    'Tháng 3',
    'Tháng 4',
    'Tháng 5',
    'Tháng 6',
    'Tháng 7',
    'Tháng 8',
    'Tháng 9',
    'Tháng 10',
    'Tháng 11',
    'Tháng 12',
  ];

  static const List<String> _weekDays = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];

  int get _daysInMonth => DateTime(year, month + 1, 0).day;

  int get _firstWeekday {
    final firstDay = DateTime(year, month, 1);
    return firstDay.weekday == 7 ? 7 : firstDay.weekday;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isThisMonth = year == now.year && month == now.month;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Month name
        Text(
          _monthNames[month - 1],
          style: context.textStyle.bodyLSemiBold.copyWith(
            color: isThisMonth ? context.color.primary : context.color.black,
          ),
        ),
        Space.h6(),

        // Weekday headers
        Row(
          children: _weekDays
              .map(
                (day) => Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: context.textStyle.bodySssMedium.gray7(context),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        Space.h2(),

        // Calendar grid
        Expanded(
          child: CalendarGrid(
            year: year,
            month: month,
            daysInMonth: _daysInMonth,
            firstWeekday: _firstWeekday,
          ),
        ),
      ],
    );
  }
}

class CalendarGrid extends StatelessWidget {
  final int year;
  final int month;
  final int daysInMonth;
  final int firstWeekday;

  const CalendarGrid({
    required this.year,
    required this.month,
    required this.daysInMonth,
    required this.firstWeekday,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: constraints.maxWidth / (constraints.maxHeight * 7 / 6),
          ),
          itemCount: 42, // 6 weeks * 7 days
          itemBuilder: (context, index) {
            final dayNumber = index - firstWeekday + 2;

            if (dayNumber < 1 || dayNumber > daysInMonth) {
              return const SizedBox.shrink(); // Empty cell
            }

            // Check if it's today
            final isToday = year == now.year && month == now.month && dayNumber == now.day;

            return Center(
              child: isToday
                  ? Container(
                      width: 15,
                      height: 15,
                      padding: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 2),
                      decoration: BoxDecoration(color: context.color.primary, borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          '$dayNumber',
                          style: context.textStyle.bodySssSemiBold.white(context),
                        ),
                      ),
                    )
                  : Text('$dayNumber', style: context.textStyle.bodySssSemiBold.black(context)),
            );
          },
        );
      },
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
