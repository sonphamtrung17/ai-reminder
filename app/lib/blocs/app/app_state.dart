import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';
import '../../theme/theme.dart';
import '../base/base_state.dart';

part 'app_state.freezed.dart';

@freezed
sealed class AppState extends BaseState with _$AppState {
  const AppState._();

  const factory AppState({
    @Default(false) bool isLoggedIn,
    @Default(false) bool isDarkTheme,
    @Default(LanguageCode.vi) LanguageCode languageCode,
    @Default(AppThemeType.light) AppThemeType appThemeType,
    @Default(0) int indexBottomTab,
  }) = _AppState;
}
