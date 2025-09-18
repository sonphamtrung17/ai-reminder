import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../../../../components/components.dart';
import '../../../../resource/resource.dart';
import '../../../../theme/theme.dart';

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
  late AnimationController _controller;
  late Animation<Rect?> _rectAnimation;

  late DateTime currentDate;
  late int selectedDay;

  // Sample events data
  Map<int, List<CalendarEvent>> events = {
    1: [CalendarEvent('Gặp đối tác', AppColors.cyan)],
    3: [
      CalendarEvent('Sinh nhật', AppColors.blue),
      CalendarEvent('Gặp đối tác', AppColors.cyan),
      CalendarEvent('Kỉ niệm ngày cưới', const Color(0xFFEE0AA9)),
    ],
    14: [CalendarEvent('Sinh nhật', AppColors.blue)],
    22: [CalendarEvent('Gặp đối tác', AppColors.cyan), CalendarEvent('Sinh nhật', AppColors.blue)],
    29: [CalendarEvent('Kỉ niệm ngày cưới', const Color(0xFFEE0AA9))],
  };

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    currentDate = widget.year != null && widget.month != null
        ? DateTime(widget.year!, widget.month!, 1)
        : DateTime(now.year, now.month, 1);
    selectedDay = now.day;

    _initializeAnimations();
  }

  void _initializeAnimations() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // const CalendarSwitchViewMode(),
              // const Spacer(),
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
          // Weekday headers
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
          Hero(
            tag: 'week_${widget.weekIndex}',
            child: Material(
              color: Colors.transparent,
              child: Row(
                children: List.generate(7, (dayIndex) {
                  final int index = widget.weekIndex * 7 + dayIndex;
                  return Expanded(child: _buildCalendarCell(index));
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarCell(int index) {
    // Calculate the day number
    final int firstDayOfWeek = DateTime(currentDate.year, currentDate.month, 1).weekday;
    final int adjustedFirstDay = firstDayOfWeek == 7 ? 0 : firstDayOfWeek; // Adjust Sunday to 0

    final int dayNumber = index - adjustedFirstDay + 1;
    final int daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;
    final int daysInPrevMonth = DateTime(currentDate.year, currentDate.month, 0).day;

    final bool isCurrentMonth = dayNumber > 0 && dayNumber <= daysInMonth;
    final bool isPrevMonth = dayNumber <= 0;
    final bool isNextMonth = dayNumber > daysInMonth;

    int displayDay;
    String lunarDate = '';

    if (isPrevMonth) {
      displayDay = daysInPrevMonth + dayNumber;
      lunarDate = '${displayDay + 3}/${currentDate.month - 1 == 0 ? 12 : currentDate.month - 1}';
    } else if (isNextMonth) {
      displayDay = dayNumber - daysInMonth;
      lunarDate = '${displayDay + 7}/${currentDate.month + 1 > 12 ? 1 : currentDate.month + 1}';
    } else {
      displayDay = dayNumber;
      lunarDate = '${displayDay + 3}/6'; // Sample lunar dates
    }

    final bool isSelected = isCurrentMonth && displayDay == selectedDay;

    final List<CalendarEvent> dayEvents = isCurrentMonth ? (events[displayDay] ?? []) : [];

    return GestureDetector(
      onTap: () {
        if (isCurrentMonth) {
          setState(() {
            selectedDay = displayDay;
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
                color: isSelected ? context.color.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  displayDay.toString(),
                  style: context.textStyle.bodyMSemiBold.copyWith(
                    color: isSelected ? context.color.white : context.color.black,
                  ),
                ),
              ),
            ),
          ).wrapPadding(const EdgeInsets.only(top: 6, bottom: 4)),
          // Lunar date - ngay bên dưới số ngày
          Opacity(
            opacity: isCurrentMonth ? 1 : 0.5,
            child: Text(
              lunarDate,
              style: context.textStyle.bodySssRegular.black(context),
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarEvent {
  final String title;
  final Color color;

  CalendarEvent(this.title, this.color);
}
