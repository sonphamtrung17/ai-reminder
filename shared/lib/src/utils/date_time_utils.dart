import 'package:intl/intl.dart';

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

  /// ex: 14/02/2023
  String get convertTimeToDDMMYY {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatted = formatter.format(this);
    return formatted;
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

  static bool isCurrentMonth(DateTime month) {
    final now = DateTime.now();
    return month.year == now.year && month.month == now.month;
  }

  static bool isSameMonth(DateTime month1, DateTime month2) {
    return month1.year == month2.year && month1.month == month2.month;
  }

  static bool isInMonth(DateTime month, DateTime date) {
    return month.year == date.year && month.month == date.month;
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

  /// Sinh ra các ngày của 1 tháng (6x7)
  static List<DateTime> generateDayInMonth(DateTime month) {
    /// Ngày đầu tiên của tháng hiện tại
    final firstDayOfMonth = DateTime(month.year, month.month, 1);

    /// Số ngày trong tháng hiện tại
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;

    /// Thứ của ngày đầu tiên trong tháng (1 = Thứ 2, 7 = Chủ nhật)
    final firstWeekday = firstDayOfMonth.weekday; // 1 = Mon, 7 = Sun

    /// Số ô trống ở đầu (leading) để căn chỉnh ngày đầu tiên của tháng vào đúng vị trí trong tuần
    final leading = firstWeekday - 1;

    /// Số ngày trong tháng trước
    final prevMonth = DateTime(month.year, month.month - 1, 1);
    final daysInPrevMonth = DateTime(month.year, month.month, 0).day;

    final List<DateTime> grid = [];

    /// Thêm ngày của tháng trước
    /// Ví dụ: nếu ngày 1 của tháng hiện tại là Thứ 6, thì firstWeekday = 5
    /// -> leading = 4 -> cần hiển thị 4 ngày cuối cùng của tháng trước.
    for (int i = 0; i < leading; i++) {
      final int day = daysInPrevMonth - leading + 1 + i;
      grid.add(DateTime(prevMonth.year, prevMonth.month, day));
    }

    /// Thêm toàn bộ ngày từ 1 → hết tháng.
    for (int d = 1; d <= daysInMonth; d++) {
      grid.add(DateTime(month.year, month.month, d));
    }

    /// Sau khi thêm tháng trước và tháng hiện tại, có thể tuần cuối cùng chưa đủ 7 ngày → tính trailing để bù cho đủ.
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
