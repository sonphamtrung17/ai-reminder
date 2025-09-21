import 'package:injectable/injectable.dart';

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

  void onSetCalendarViewMode(CalendarViewMode current) {
    emit(state.copyWith(calendarViewMode: current));
  }

  void onSetDayViewMode(DayViewMode dayViewMode) {
    emit(state.copyWith(dayViewMode: dayViewMode));
  }

  void onSetFocusedDate(DateTime date) {
    emit(state.copyWith(focusedDate: date));
  }

  void onBackPressed() {
    switch (state.calendarViewMode) {
      case CalendarViewMode.year:
        return;
      case CalendarViewMode.month:
        emit(
          state.copyWith(
            calendarViewMode: CalendarViewMode.year,
            previousViewMode: null,
          ),
        );
        break;
      case CalendarViewMode.week:
        emit(
          state.copyWith(
            calendarViewMode: CalendarViewMode.month,
            previousViewMode: CalendarViewMode.year,
          ),
        );
        break;
    }
  }
}
