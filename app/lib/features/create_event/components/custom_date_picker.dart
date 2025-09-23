import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../../../components/components.dart';
import '../../../resource/resource.dart';
import '../../../theme/theme.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime)? onDateSelected;

  const CustomDatePicker({
    required this.initialDate,
    super.key,
    this.onDateSelected,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime currentMonth;
  late DateTime selectedDate;

  TimeOfDay startTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 0, minute: 0);

  @override
  void initState() {
    super.initState();

    currentMonth = widget.initialDate;
    selectedDate = widget.initialDate;
  }

  void _selectDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    widget.onDateSelected?.call(date);
  }

  void _previousMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    });
  }

  String _getMonthYear(DateTime date) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[date.month]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTimeUtils.generateDayInMonth(currentMonth);

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              AppButton.icon(
                iconPath: Assets.icons.icEventCalendarArrowLeft,
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.all(8),
                onPressed: _previousMonth,
              ),
              Row(
                children: [
                  Text(
                    _getMonthYear(currentMonth),
                    style: context.textStyle.bodyLMedium.black(context),
                  ),
                  Space.w4(),
                  AppImage.asset(path: Assets.icons.icEventCalendarArrowDropDown),
                ],
              ).wrapPadding(const EdgeInsets.symmetric(horizontal: 8)),
              AppButton.icon(
                iconPath: Assets.icons.icEventCalendarArrowRight,
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.all(8),
                onPressed: _nextMonth,
              ),
            ],
          ),
          Space.h4(),
          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
            ),
            child: Row(
              children: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']
                  .map(
                    (day) => Expanded(
                      child: Text(
                        day,
                        textAlign: TextAlign.center,
                        style: context.textStyle.bodySRegular.gray7(context),
                      ).wrapPadding(const EdgeInsets.symmetric(vertical: 10)),
                    ),
                  )
                  .toList(),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
            ),
            itemCount: daysInMonth.length,
            itemBuilder: (context, index) {
              final date = daysInMonth[index];
              final isCurrentMonth = DateTimeUtils.isSameMonth(date, currentMonth);
              final isSelected = DateTimeUtils.isSameDate(date, selectedDate);
              final isToday = DateTimeUtils.isToday(date);

              return GestureDetector(
                onTap: () => _selectDate(date),
                child: Opacity(
                  opacity: isCurrentMonth ? 1 : 0.5,
                  child: Container(
                    width: 24,
                    height: 24,
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isSelected ? context.color.primary : Colors.transparent,
                      border: Border.all(color: isToday ? context.color.black : Colors.transparent, width: 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                        style: context.textStyle.bodyMSemiBold.copyWith(
                          color: isSelected ? context.color.white : context.color.black,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
