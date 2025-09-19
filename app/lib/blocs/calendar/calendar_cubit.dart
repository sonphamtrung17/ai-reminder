import 'package:injectable/injectable.dart';

import '../../features/calendar/calendar_screen.dart';
import '../../features/calendar/components/month/calendar_switch_day_view_mode.dart';
import '../base/base_cubit.dart';
import 'calendar_state.dart';

@LazySingleton()
class CalendarCubit extends BaseCubit<CalendarState> {
  CalendarCubit() : super(CalendarState(focusedDate: DateTime.now()));

  // void checkTitleAppBar() {
  //   if (state.calendarViewMode == CalendarViewMode.year) {
  //     emit(state.copyWith(titleAppBar: 'Lịch năm'));
  //   } else {
  //     if (state.dayViewMode == DayViewMode.week) {
  //       emit(state.copyWith(titleAppBar: 'Lịch tuần'));
  //     } else {
  //       emit(state.copyWith(titleAppBar: 'Lịch tháng'));
  //     }
  //   }
  // }

  void checkCurrentRoute() {
    if (state.calendarViewMode == CalendarViewMode.year) {
      emit(state.copyWith(currentRoute: CalendarRoute.year));
    } else {
      if (state.dayViewMode == DayViewMode.week) {
        emit(state.copyWith(currentRoute: CalendarRoute.week));
      } else {
        emit(state.copyWith(currentRoute: CalendarRoute.month));
      }
    }
  }

  void setDayViewMode(DayViewMode dayViewMode) {
    emit(state.copyWith(dayViewMode: dayViewMode));
  }

  void setCalendarViewMode(CalendarViewMode calendarViewMode) {
    emit(state.copyWith(calendarViewMode: calendarViewMode));
  }
}
