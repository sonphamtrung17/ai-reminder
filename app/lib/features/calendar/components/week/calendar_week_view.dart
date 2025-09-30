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
import '../month/calendar_switch_day_view_mode.dart';
import 'calendar_week_event_view.dart';

@RoutePage()
class CalendarWeekView extends StatefulWidget {
  final int weekIndex;
  final int? year;
  final int? month;

  const CalendarWeekView({
    required this.weekIndex,
    this.year,
    this.month,
    super.key,
  });

  @override
  State<CalendarWeekView> createState() => _CalendarWeekViewState();
}

class _CalendarWeekViewState extends State<CalendarWeekView> with SingleTickerProviderStateMixin {
  final _calendarCubit = GetIt.instance.get<CalendarCubit>();

  late DateTime currentMonth;
  late DateTime selectedDate;

  // Sample events data
  final Map<DateTime, List<CalendarEvent>> events = {};

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    currentMonth = widget.year != null && widget.month != null
        ? DateTime(widget.year!, widget.month!, 1)
        : DateTime(now.year, now.month, 1);
    selectedDate = now;

    // Fake sample events
    events[DateTime(now.year, now.month, 1)] = [
      CalendarEvent(
        'Gặp đối tác',
        AppColors.cyan,
        DateTime(now.year, now.month, 1, 1, 0),
        DateTime(now.year, now.month, 1, 3, 0),
      ),
    ];
    events[DateTime(now.year, now.month, 3)] = [
      CalendarEvent(
        'Sinh nhật',
        AppColors.blue,
        DateTime(now.year, now.month, 3, 1, 0),
        DateTime(now.year, now.month, 3, 3, 0),
      ),
      CalendarEvent(
        'Gặp đối tác',
        AppColors.cyan,
        DateTime(now.year, now.month, 3, 4, 0),
        DateTime(now.year, now.month, 3, 6, 0),
      ),
      CalendarEvent(
        'Kỉ niệm ngày cưới',
        const Color(0xFFEE0AA9),
        DateTime(now.year, now.month, 3, 6, 0),
        DateTime(now.year, now.month, 3, 9, 0),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final weekDates = DateTimeUtils.generateDayInWeek(currentMonth, widget.weekIndex);

    return Scaffold(
      body: Column(
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
          Space.h4(),
          BlocBuilder<CalendarCubit, CalendarState>(
            buildWhen: (previous, current) => previous.dayViewMode != current.dayViewMode,
            bloc: _calendarCubit,
            builder: (context, state) {
              return Row(
                children: weekDates.map((date) {
                  return Expanded(child: _buildCalendarCell(date));
                }).toList(),
              ).wrapPadding(const EdgeInsets.symmetric(horizontal: 8));
            },
          ),
          Center(
            child: Text(
              selectedDate.toVietnameseString,
              style: context.textStyle.bodyLSemiBold.black(context),
            ).wrapPadding(const EdgeInsets.symmetric(vertical: 8)),
          ),
          CalendarWeekEventView(events: events[selectedDate] ?? []),
        ],
      ),
    );
  }

  Widget _buildCalendarCell(DateTime cellDate) {
    final isCurrentMonth = cellDate.month == currentMonth.month;
    final isSelected = DateTimeUtils.isSameDate(cellDate, selectedDate);
    final isToday = DateTimeUtils.isToday(cellDate);

    final showLunar = _calendarCubit.state.dayViewMode != DayViewMode.dl;
    String lunarDisplay = '';
    if (showLunar) {
      final lunar = LunarUtils.solarToLunar(cellDate);
      lunarDisplay = '${lunar.day}/${lunar.month}';
    }
    final double opacityLunar = !showLunar ? 0 : (isCurrentMonth ? 1 : 0.5);

    return Container(
      decoration: isSelected
          ? BoxDecoration(
              border: Border.all(color: context.color.primary, width: 1),
              borderRadius: BorderRadius.circular(10),
            )
          : null,
      child: InkWell(
        onTap: () {
          if (isCurrentMonth) {
            setState(() {
              selectedDate = cellDate;
            });
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Opacity(
              opacity: isCurrentMonth ? 1 : 0.5,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isToday ? context.color.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    cellDate.day.toString(),
                    style: context.textStyle.bodyMSemiBold.copyWith(
                      color: isToday ? context.color.white : context.color.black,
                    ),
                  ),
                ),
              ),
            ).wrapPadding(const EdgeInsets.only(top: 8, bottom: 2)),
            Opacity(
              opacity: opacityLunar,
              child: Text(
                lunarDisplay,
                style: context.textStyle.bodySssRegular.black(context),
              ),
            ),
            Space.h8(),
          ],
        ),
      ),
    );
  }
}

class CalendarEvent {
  final String title;
  final Color color;
  final DateTime start;
  final DateTime end;

  CalendarEvent(
    this.title,
    this.color,
    this.start,
    this.end,
  );
}
