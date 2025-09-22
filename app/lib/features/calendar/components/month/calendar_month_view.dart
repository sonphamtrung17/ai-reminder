import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/shared.dart';

import '../../../../blocs/calendar/calendar_cubit.dart';
import '../../../../blocs/calendar/calendar_state.dart';
import '../../../../components/components.dart';
import '../../../../resource/resource.dart';
import '../../../../theme/theme.dart';
import 'calendar_switch_day_view_mode.dart';

@RoutePage()
class CalendarMonthView extends StatefulWidget {
  final int? year;
  final int? month;

  const CalendarMonthView({this.year, this.month, super.key});

  @override
  State<CalendarMonthView> createState() => _CalendarMonthViewState();
}

class _CalendarMonthViewState extends State<CalendarMonthView> {
  final _calendarCubit = GetIt.instance.get<CalendarCubit>();

  late DateTime currentMonth;

  // Sample events data
  final Map<DateTime, List<CalendarEvent>> events = {};

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    currentMonth = widget.year != null && widget.month != null
        ? DateTime(widget.year!, widget.month!, 1)
        : DateTime(now.year, now.month, 1);

    // Fake sample events
    events[DateTime(now.year, now.month, 1)] = [CalendarEvent('Gặp đối tác', AppColors.cyan)];
    events[DateTime(now.year, now.month, 3)] = [
      CalendarEvent('Sinh nhật', AppColors.blue),
      CalendarEvent('Gặp đối tác', AppColors.cyan),
      CalendarEvent('Kỉ niệm ngày cưới', const Color(0xFFEE0AA9)),
    ];
  }

  void _onWeekTap(int weekIndex) {
    _calendarCubit.onSetCalendarViewModeWeek(weekIndex, currentMonth.year, currentMonth.month);
  }

  @override
  Widget build(BuildContext context) {
    final gridDates = DateTimeUtils.generateDayInMonth(currentMonth);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CalendarSwitchViewMode(),
            const Spacer(),
            AppButton.textIcon(
              text: 'Đồng bộ',
              iconPath: Assets.icons.icCalendarSync,
              backgroundColor: Colors.transparent,
              textStyle: context.textStyle.bodyMMedium.primary(context),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              spacing: 4,
              onPressed: () {},
            ),
          ],
        ).wrapPadding(const EdgeInsets.symmetric(vertical: 8)),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: context.color.border, width: 1)),
          ),
          child: Row(
            children: CalendarConstants.weekDays
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: Text(day, style: context.textStyle.bodyMRegular.gray7(context)),
                    ),
                  ),
                )
                .toList(),
          ),
        ).wrapPadding(const EdgeInsets.symmetric(horizontal: 8)),
        BlocBuilder<CalendarCubit, CalendarState>(
          bloc: _calendarCubit,
          buildWhen: (previous, current) => previous.dayViewMode != current.dayViewMode,
          builder: (context, state) {
            return Expanded(
              child: Column(
                children: List.generate(6, (week) {
                  final rowDates = gridDates.skip(week * 7).take(7).toList();
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => _onWeekTap(week),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: context.color.border, width: 1)),
                        ),
                        child: Row(
                          children: rowDates.map((d) => Expanded(child: _buildCalendarCell(d))).toList(),
                        ),
                      ),
                    ),
                  );
                }),
              ).wrapPadding(const EdgeInsets.symmetric(horizontal: 8)),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCalendarCell(DateTime cellDate) {
    final isCurrentMonth = cellDate.month == currentMonth.month;

    final dayEvents = events[cellDate] ?? [];
    final showLunar = _calendarCubit.state.dayViewMode != DayViewMode.dl;
    String lunarDisplay = '';
    if (showLunar) {
      final lunar = LunarUtils.solarToLunar(cellDate);
      lunarDisplay = '${lunar.day}/${lunar.month}';
    }
    final double opacityLunar = !showLunar ? 0 : (isCurrentMonth ? 1 : 0.5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Opacity(
          opacity: isCurrentMonth ? 1 : 0.5,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                '${cellDate.day}',
                style: context.textStyle.bodyMSemiBold.copyWith(
                  color: context.color.black,
                ),
              ),
            ),
          ),
        ).wrapPadding(const EdgeInsets.only(top: 6, bottom: 4)),
        Opacity(
          opacity: opacityLunar,
          child: Text(
            lunarDisplay,
            style: context.textStyle.bodySssRegular.black(context),
          ),
        ),
        Space.h2(),
        Expanded(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: dayEvents
                  .map(
                    (event) => Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 2, left: 2, right: 2),
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        color: event.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          event.title,
                          style: context.textStyle.bodySssMedium.copyWith(color: event.color),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class CalendarEvent {
  final String title;
  final Color color;

  CalendarEvent(this.title, this.color);
}
