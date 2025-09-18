import 'package:injectable/injectable.dart';

import '../../features/calendar/calendar_tab.dart';
import '../../features/calendar/components/month/calendar_switch_day_view_mode.dart';
import '../base/base_cubit.dart';
import 'calendar_state.dart';

@Injectable()
class CalendarCubit extends BaseCubit<CalendarState> {
  CalendarCubit() : super(CalendarState());

  void setDayViewMode(DayViewMode dayViewMode) {
    emit(state.copyWith(dayViewMode: dayViewMode));
  }

  void setCalendarViewMode(CalendarViewMode calendarViewMode) {
    emit(state.copyWith(calendarViewMode: calendarViewMode));
  }
}
