import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../features/calendar/calendar_screen.dart';
import '../../features/calendar/components/month/calendar_switch_day_view_mode.dart';
import '../base/base_cubit.dart';
import 'calendar_state.dart';

@LazySingleton()
class CalendarCubit extends BaseCubit<CalendarState> {
  CalendarCubit() : super(CalendarState(focusedDate: DateTime.now()));

  String get titleAppBar {
    if (state.focusedDate == null) {
      return '';
    }

    switch (state.calendarViewMode) {
      case CalendarViewMode.year:
        return '${state.focusedDate!.year}';
      case CalendarViewMode.month:
      case CalendarViewMode.week:
        return 'Tháng ${state.focusedDate!.month} năm ${state.focusedDate!.year}';
    }
  }

  void onSetCalendarViewModeFromPopup(CalendarViewMode mode) {
    if (state.week == null) {
      final today = DateTime.now();

      /// Nếu year/month null → lấy theo hôm nay
      final currentYear = state.focusedDate?.year ?? today.year;
      final currentMonth = state.focusedDate?.month ?? today.month;
      final currentMonthDate = DateTime(currentYear, currentMonth, 1);

      final effectiveWeekIndex = DateTimeUtils.findWeekIndexOfDate(currentMonthDate, today);
      emit(state.copyWith(calendarViewMode: mode, week: effectiveWeekIndex));
    } else {
      emit(state.copyWith(calendarViewMode: mode));
    }
  }

  void onSetCalendarViewModeMonth(DateTime focusedDate) {
    emit(state.copyWith(calendarViewMode: CalendarViewMode.month, focusedDate: focusedDate));
  }

  void onSetCalendarViewModeWeek(int week, int year, int month) {
    emit(state.copyWith(calendarViewMode: CalendarViewMode.week, week: week, focusedDate: DateTime(year, month, 1)));
  }

  void onSetDayViewMode(DayViewMode dayViewMode) {
    emit(state.copyWith(dayViewMode: dayViewMode));
  }

  void onSetFocusedDate(DateTime focusedDate) {
    emit(state.copyWith(focusedDate: focusedDate));
  }

  void onBackPressed() {
    switch (state.calendarViewMode) {
      case CalendarViewMode.year:
        return;
      case CalendarViewMode.month:
        emit(
          state.copyWith(calendarViewMode: CalendarViewMode.year),
        );
        break;
      case CalendarViewMode.week:
        emit(
          state.copyWith(calendarViewMode: CalendarViewMode.month),
        );
        break;
    }
  }
}
