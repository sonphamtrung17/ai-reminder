extension DateTimeX on DateTime {
  DateTime get startOfMonth => DateTime(year, month, 1);

  DateTime get endOfMonth => DateTime(year, month + 1, 0);

  /// Thứ 5 ngày 21 tháng 8 năm 2025
  String get toVietnameseString {
    const weekdays = [
      'Chủ nhật',
      'Thứ 2',
      'Thứ 3',
      'Thứ 4',
      'Thứ 5',
      'Thứ 6',
      'Thứ 7',
    ];

    return '${weekdays[weekday % 7]} ngày $day tháng $month năm $year';
  }
}

class DateTimeUtils {
  const DateTimeUtils._();

  static int findWeekIndexOfDate(DateTime month, DateTime date) {
    final monthGrid = generateDayInMonth(month); // 42 ô
    for (int i = 0; i < monthGrid.length; i++) {
      if (isSameDate(monthGrid[i], date)) {
        return i ~/ 7; // chia lấy tuần
      }
    }
    return 0; // fallback
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return isSameDate(now, date);
  }

  static bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Sinh ra 7 ngày của 1 tuần trong tháng
  static List<DateTime> generateDayInWeek(DateTime month, int weekIndex) {
    final monthGrid = generateDayInMonth(month); // 42 ô
    final start = weekIndex * 7;
    final end = start + 7;

    return monthGrid.sublist(start, end);
  }

  /// Sinh ra các ngày của 1 tháng
  static List<DateTime> generateDayInMonth(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final firstWeekday = firstDayOfMonth.weekday; // 1 = Mon, 7 = Sun
    final leading = firstWeekday - 1;

    final prevMonth = DateTime(month.year, month.month - 1, 1);
    final daysInPrevMonth = DateTime(month.year, month.month, 0).day;

    final List<DateTime> grid = [];

    // prev month days
    for (int i = 0; i < leading; i++) {
      final int day = daysInPrevMonth - leading + 1 + i;
      grid.add(DateTime(prevMonth.year, prevMonth.month, day));
    }

    // current month days
    for (int d = 1; d <= daysInMonth; d++) {
      grid.add(DateTime(month.year, month.month, d));
    }

    // next month days
    final trailing = (7 - grid.length % 7) % 7;
    final nextMonth = DateTime(month.year, month.month + 1, 1);
    for (int i = 0; i < trailing; i++) {
      grid.add(DateTime(nextMonth.year, nextMonth.month, i + 1));
    }

    while (grid.length < 42) {
      final last = grid.last;
      grid.add(last.add(const Duration(days: 1)));
    }

    return grid;
  }
}
