import 'package:freezed_annotation/freezed_annotation.dart';

import '../../features/calendar/calendar_tab.dart';
import '../base/base_state.dart';

part 'calendar_state.freezed.dart';

@freezed
sealed class CalendarState extends BaseState with _$CalendarState {
  const CalendarState._();

  factory CalendarState({
    @Default(CalendarViewMode.year) CalendarViewMode calendarViewMode,
  }) = _CalendarState;
}
