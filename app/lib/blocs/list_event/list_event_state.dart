import 'package:freezed_annotation/freezed_annotation.dart';

import '../base/base_state.dart';

part 'list_event_state.freezed.dart';

@freezed
sealed class ListEventState extends BaseState with _$ListEventState {
  const ListEventState._();

  factory ListEventState.initial() = ListEventStateInitial;
}
