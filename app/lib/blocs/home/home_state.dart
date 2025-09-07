import 'package:freezed_annotation/freezed_annotation.dart';

import '../base/base_state.dart';

part 'home_state.freezed.dart';

@freezed
sealed class HomeState extends BaseState with _$HomeState {
  const HomeState._();

  factory HomeState.initial() = HomeStateInitial;
}
