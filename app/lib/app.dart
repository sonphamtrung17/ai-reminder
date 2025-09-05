import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import 'blocs/app/app_cubit.dart';
import 'blocs/app/app_state.dart';
import 'blocs/base/base_screen_state.dart';
import 'navigation/navigation.dart';
import 'theme/app_themes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends BaseScreenState<App, AppCubit> {
  final _appRouter = GetIt.instance.get<AppRouter>();

  @override
  bool get isAppWidget => true;

  @override
  void initState() {
    super.initState();
    bloc.onAppInitiated();
  }

  @override
  Widget buildPage(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        DeviceConstants.designDeviceWidth,
        DeviceConstants.designDeviceHeight,
      ),
      builder: (context, _) => BlocBuilder<AppCubit, AppState>(
        buildWhen: (previous, current) =>
            previous.isDarkTheme != current.isDarkTheme ||
            previous.appThemeType != current.appThemeType ||
            previous.languageCode != current.languageCode,
        builder: (context, state) {
          ThemeData theme;
          ThemeData darkTheme;

          switch (state.appThemeType) {
            case AppThemeType.light:
              theme = AppTheme.light().data;
              darkTheme = AppTheme.dark().data;
            case AppThemeType.dark:
              theme = AppTheme.dark().data;
              darkTheme = AppTheme.dark().data;
          }

          return MaterialApp.router(
            builder: (context, child) {
              final data = MediaQuery.of(context);

              return MediaQuery(
                data: data.copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child ?? const SizedBox.shrink(),
              );
            },
            routerDelegate: _appRouter.delegate(
              navigatorObservers: () => [AppNavigatorObserver()],
            ),
            routeInformationParser: _appRouter.defaultRouteParser(),
            title: UiConstants.materialAppTitle,
            color: UiConstants.taskMenuMaterialAppColor,
            themeMode: state.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
            theme: theme,
            darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            localeResolutionCallback:
                (Locale? locale, Iterable<Locale> supportedLocales) =>
                    supportedLocales.contains(locale)
                    ? locale
                    : Locale(LanguageCode.defaultValue.localeCode),
            locale: Locale(state.languageCode.localeCode),
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: const [
              S.delegate,
              DefaultCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
