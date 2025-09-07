import 'package:flutter/material.dart';

import 'theme.dart';

enum AppThemeType {
  light,
  dark;

  static AppThemeType fromName(String name) {
    return AppThemeType.values.firstWhere(
      (e) => e.name == name,
      orElse: () => AppThemeType.light,
    );
  }
}

class AppTheme {
  final ThemeData data;

  const AppTheme({required this.data});

  static const fontFamily = 'PlusJakartaSans';

  factory AppTheme.light() => AppTheme(
    data: ThemeData(
      brightness: Brightness.light,
      splashColor: Colors.transparent,
      fontFamily: fontFamily,
      extensions: [
        /// Guideline Typography Token
        const GuidelineColor(
          white: AppColors.white,
          black: AppColors.black,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          blue: AppColors.blue,
          cyan: AppColors.cyan,
          green: AppColors.green,
          yellow: AppColors.yellow,
          red: AppColors.red,
          gray1: AppColors.gray1,
          gray2: AppColors.gray2,
          gray3: AppColors.gray3,
          gray4: AppColors.gray4,
          gray5: AppColors.gray5,
          gray6: AppColors.gray6,
          gray7: AppColors.gray7,
          gray8: AppColors.gray8,
          gray9: AppColors.gray9,
          gray10: AppColors.gray10,
          danger: AppColors.danger,
          success: AppColors.success,
          warning: AppColors.warning,
          border: AppColors.border,
          background: AppColors.background,
          background2: AppColors.background2,
        ),

        /// Guideline Typography
        _guidelineTypography,
      ],
    ),
  );

  factory AppTheme.dark() => AppTheme(
    data: ThemeData(
      brightness: Brightness.dark,
      splashColor: Colors.transparent,
      fontFamily: fontFamily,
      extensions: [
        /// Guideline Typography Token
        const GuidelineColor(
          white: AppColors.white,
          black: AppColors.black,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          blue: AppColors.blue,
          cyan: AppColors.cyan,
          green: AppColors.green,
          yellow: AppColors.yellow,
          red: AppColors.red,
          gray1: AppColors.gray1,
          gray2: AppColors.gray2,
          gray3: AppColors.gray3,
          gray4: AppColors.gray4,
          gray5: AppColors.gray5,
          gray6: AppColors.gray6,
          gray7: AppColors.gray7,
          gray8: AppColors.gray8,
          gray9: AppColors.gray9,
          gray10: AppColors.gray10,
          danger: AppColors.danger,
          success: AppColors.success,
          warning: AppColors.warning,
          border: AppColors.border,
          background: AppColors.background,
          background2: AppColors.background2,
        ),

        /// Guideline Typography
        _guidelineTypography,
      ],
    ),
  );

  static final _guidelineTypography = GuidelineTypography(
    // Heading XL
    headingXlRegular: GuidelineTextStyle.headingXlRegular,
    headingXlMedium: GuidelineTextStyle.headingXlMedium,
    headingXlSemiBold: GuidelineTextStyle.headingXlSemiBold,
    headingXlBold: GuidelineTextStyle.headingXlBold,

    // Heading L
    headingLRegular: GuidelineTextStyle.headingLRegular,
    headingLMedium: GuidelineTextStyle.headingLMedium,
    headingLSemiBold: GuidelineTextStyle.headingLSemiBold,
    headingLBold: GuidelineTextStyle.headingLBold,

    // Heading M
    headingMRegular: GuidelineTextStyle.headingMRegular,
    headingMMedium: GuidelineTextStyle.headingMMedium,
    headingMSemiBold: GuidelineTextStyle.headingMSemiBold,
    headingMBold: GuidelineTextStyle.headingMBold,

    // Heading S
    headingSRegular: GuidelineTextStyle.headingSRegular,
    headingSMedium: GuidelineTextStyle.headingSMedium,
    headingSSemiBold: GuidelineTextStyle.headingSSemiBold,
    headingSBold: GuidelineTextStyle.headingSBold,

    // Heading XS
    headingXsRegular: GuidelineTextStyle.headingXsRegular,
    headingXsMedium: GuidelineTextStyle.headingXsMedium,
    headingXsSemiBold: GuidelineTextStyle.headingXsSemiBold,
    headingXsBold: GuidelineTextStyle.headingXsBold,

    // Body XL
    bodyXlRegular: GuidelineTextStyle.bodyXlRegular,
    bodyXlMedium: GuidelineTextStyle.bodyXlMedium,
    bodyXlSemiBold: GuidelineTextStyle.bodyXlSemiBold,

    // Body L
    bodyLRegular: GuidelineTextStyle.bodyLRegular,
    bodyLMedium: GuidelineTextStyle.bodyLMedium,
    bodyLSemiBold: GuidelineTextStyle.bodyLSemiBold,

    // Body M
    bodyMRegular: GuidelineTextStyle.bodyMRegular,
    bodyMMedium: GuidelineTextStyle.bodyMMedium,
    bodyMSemiBold: GuidelineTextStyle.bodyMSemiBold,

    // Body S
    bodySRegular: GuidelineTextStyle.bodySRegular,
    bodySMedium: GuidelineTextStyle.bodySMedium,
    bodySSemiBold: GuidelineTextStyle.bodySSemiBold,

    // Body SS
    bodySsRegular: GuidelineTextStyle.bodySSRegular,
    bodySsMedium: GuidelineTextStyle.bodySSMedium,
    bodySsSemiBold: GuidelineTextStyle.bodySSSemiBold,

    // Body SSS
    bodySssRegular: GuidelineTextStyle.bodySSSRegular,
    bodySssMedium: GuidelineTextStyle.bodySSSMedium,
    bodySssSemiBold: GuidelineTextStyle.bodySSSSemiBold,
  );
}

extension ThemeContext on BuildContext {
  GuidelineColor get color => Theme.of(this).extension<GuidelineColor>()!;

  ThemeData get theme => Theme.of(this);

  GuidelineTypography get textStyle => Theme.of(this).extension<GuidelineTypography>()!;
}
