import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';
import '../base/base_cubit_state.dart';

part 'app_state.freezed.dart';

@freezed
sealed class AppState extends BaseCubitState with _$AppState {
  const AppState._();

  const factory AppState({
    @Default(false) bool isLoggedIn,
    @Default(false) bool isDarkTheme,
    @Default(LanguageCode.vi) LanguageCode languageCode,
  }) = _AppState;
}
