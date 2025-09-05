import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../theme/theme.dart';
import '../base/base_cubit.dart';
import 'app_state.dart';

@LazySingleton()
class AppCubit extends BaseCubit<AppState> {
  final AppPreferences _appPreferences;

  AppCubit(this._appPreferences) : super(const AppState());

  void setIndexBottomTab(int index) {
    emit(state.copyWith(indexBottomTab: index));
  }

  Future<void> onAppInitiated() async {
    await runBlocCatching(
      handleLoading: false,
      action: () async {
        final isDarkTheme = _appPreferences.isDarkMode;
        final languageCode = LanguageCode.fromLocaleCode(
          _appPreferences.languageCode,
        );
        final appThemeType = AppThemeType.fromName(
          _appPreferences.appThemeType,
        );
        emit(
          state.copyWith(
            isDarkTheme: isDarkTheme,
            languageCode: languageCode,
            appThemeType: appThemeType,
          ),
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

  Future<void> onAppThemeChanged({required AppThemeType type}) async {
    await runBlocCatching(
      action: () async {
        await _appPreferences.saveAppThemeType(type.name);
        emit(state.copyWith(appThemeType: type));
      },
    );
  }

  Future<void> onAppIsDarkThemeChanged({required bool isDarkTheme}) async {
    await runBlocCatching(
      action: () async {
        await _appPreferences.saveIsDarkMode(isDarkTheme);
        emit(state.copyWith(isDarkTheme: isDarkTheme));
      },
    );
  }
}
