import 'package:freezed_annotation/freezed_annotation.dart';

import '../base/base_state.dart';

part 'main_state.freezed.dart';

@freezed
sealed class MainState extends BaseState with _$MainState {
  const MainState._();

  const factory MainState({
    @Default(0.0) double heightBottomNavigationBar,
  }) = _MainState;
}
