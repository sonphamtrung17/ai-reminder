import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../theme/theme.dart';
import '../base/base_cubit.dart';
import 'app_state.dart';

@LazySingleton()
class AppCubit extends BaseCubit<AppState> {
  final AppPreferences _appPreferences;

  AppCubit(this._appPreferences) : super(const AppState());

  Future<void> onAppInitiated() async {
    await runBlocCatching(
      handleLoading: false,
      action: () async {
        final isDarkTheme = _appPreferences.isDarkMode;
        final languageCode = LanguageCode.fromLocaleCode(
          _appPreferences.languageCode,
        );
        _updateThemeSetting(isDarkTheme);
        emit(
          state.copyWith(isDarkTheme: isDarkTheme, languageCode: languageCode),
        );
      },
    );
  }

  Future<void> onAppLanguageChanged({
    required LanguageCode languageCode,
  }) async {
    await runBlocCatching(
      action: () async {
        await _appPreferences.saveLanguageCode(languageCode.localeCode);
        emit(state.copyWith(languageCode: languageCode));
      },
    );
  }

  Future<void> onAppThemeChanged({required bool isDarkTheme}) async {
    await runBlocCatching(
      action: () async {
        await _appPreferences.saveIsDarkMode(isDarkTheme);
        _updateThemeSetting(isDarkTheme);
        emit(state.copyWith(isDarkTheme: isDarkTheme));
      },
    );
  }

  void _updateThemeSetting(bool isDarkTheme) {
    AppThemeSetting.currentAppThemeType = isDarkTheme
        ? AppThemeType.dark
        : AppThemeType.light;
  }
}
