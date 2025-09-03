import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../base/base_cubit_state.dart';

part 'splash_state.freezed.dart';

@freezed
sealed class SplashState extends BaseCubitState with _$SplashState {
  const SplashState._();

  factory SplashState({
    @Default([]) List<User> users,
    @Default(false) bool isShimmerLoading,
    AppException? loadUsersException,
  }) = _SplashState;
}
