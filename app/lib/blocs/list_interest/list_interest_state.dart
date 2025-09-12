import 'package:freezed_annotation/freezed_annotation.dart';

import '../base/base_state.dart';

part 'list_interest_state.freezed.dart';

@freezed
sealed class ListInterestState extends BaseState with _$ListInterestState {
  const ListInterestState._();

  factory ListInterestState.initial() = ListInterestStateInitial;
  factory ListInterestState.getListInterestSucceed(List<String> listInterest) = GetListInterestState;
}
