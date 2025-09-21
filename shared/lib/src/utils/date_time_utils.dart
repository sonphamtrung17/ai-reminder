class DateTimeUtils {
  const DateTimeUtils._();

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
