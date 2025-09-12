import 'package:freezed_annotation/freezed_annotation.dart';

import '../base/base_state.dart';

part 'create_interest_state.freezed.dart';

@freezed
sealed class CreateInterestState extends BaseState with _$CreateInterestState {
  const CreateInterestState._();

  factory CreateInterestState.initial() = CreateInterestStateInitial;
  factory CreateInterestState.makeCreateInterestSucceed(List<String> createInterest) = GetCreateInterestState;
}
