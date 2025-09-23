import 'package:freezed_annotation/freezed_annotation.dart';

import '../base/base_state.dart';

part 'create_event_state.freezed.dart';

@freezed
sealed class CreateEventState extends BaseState with _$CreateEventState {
  const CreateEventState._();

  factory CreateEventState.initial() = CreateEventStateInitial;
}
