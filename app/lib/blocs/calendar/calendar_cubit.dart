import 'package:injectable/injectable.dart';

import '../../features/calendar/calendar_tab.dart';
import '../base/base_cubit.dart';
import 'calendar_state.dart';

@Injectable()
class CalendarCubit extends BaseCubit<CalendarState> {
  CalendarCubit() : super(CalendarState());

  void setCalendarViewMode(CalendarViewMode calendarViewMode) {
    emit(state.copyWith(calendarViewMode: calendarViewMode));
  }
}
