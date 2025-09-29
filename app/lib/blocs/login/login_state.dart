import 'package:freezed_annotation/freezed_annotation.dart';

import '../base/base_state.dart';

part 'login_state.freezed.dart';

@freezed
sealed class LoginState extends BaseState with _$LoginState {
  const LoginState._();

  factory LoginState.initial() = LoginStateInitial;
}
