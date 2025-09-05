import 'package:flutter/material.dart';

class GuidelineTypography extends ThemeExtension<GuidelineTypography> {
  /// --- Headings ---
  final TextStyle headingXlRegular;
  final TextStyle headingXlMedium;
  final TextStyle headingXlSemiBold;
  final TextStyle headingXlBold;

  final TextStyle headingLRegular;
  final TextStyle headingLMedium;
  final TextStyle headingLSemiBold;
  final TextStyle headingLBold;

  final TextStyle headingMRegular;
  final TextStyle headingMMedium;
  final TextStyle headingMSemiBold;
  final TextStyle headingMBold;

  final TextStyle headingSRegular;
  final TextStyle headingSMedium;
  final TextStyle headingSSemiBold;
  final TextStyle headingSBold;

  final TextStyle headingXsRegular;
  final TextStyle headingXsMedium;
  final TextStyle headingXsSemiBold;
  final TextStyle headingXsBold;

  /// --- Body ---
  final TextStyle bodyXlRegular;
  final TextStyle bodyXlMedium;
  final TextStyle bodyXlSemiBold;

  final TextStyle bodyLRegular;
  final TextStyle bodyLMedium;
  final TextStyle bodyLSemiBold;

  final TextStyle bodyMRegular;
  final TextStyle bodyMMedium;
  final TextStyle bodyMSemiBold;

  final TextStyle bodySRegular;
  final TextStyle bodySMedium;
  final TextStyle bodySSemiBold;

  final TextStyle bodySsRegular;
  final TextStyle bodySsMedium;
  final TextStyle bodySsSemiBold;

  final TextStyle bodySssRegular;
  final TextStyle bodySssMedium;
  final TextStyle bodySssSemiBold;

  const GuidelineTypography({
    /// Headings
    required this.headingXlRegular,
    required this.headingXlMedium,
    required this.headingXlSemiBold,
    required this.headingXlBold,
    required this.headingLRegular,
    required this.headingLMedium,
    required this.headingLSemiBold,
    required this.headingLBold,
    required this.headingMRegular,
    required this.headingMMedium,
    required this.headingMSemiBold,
    required this.headingMBold,
    required this.headingSRegular,
    required this.headingSMedium,
    required this.headingSSemiBold,
    required this.headingSBold,
    required this.headingXsRegular,
    required this.headingXsMedium,
    required this.headingXsSemiBold,
    required this.headingXsBold,

    /// Body
    required this.bodyXlRegular,
    required this.bodyXlMedium,
    required this.bodyXlSemiBold,
    required this.bodyLRegular,
    required this.bodyLMedium,
    required this.bodyLSemiBold,
    required this.bodyMRegular,
    required this.bodyMMedium,
    required this.bodyMSemiBold,
    required this.bodySRegular,
    required this.bodySMedium,
    required this.bodySSemiBold,
    required this.bodySsRegular,
    required this.bodySsMedium,
    required this.bodySsSemiBold,
    required this.bodySssRegular,
    required this.bodySssMedium,
    required this.bodySssSemiBold,
  });

  @override
  GuidelineTypography copyWith({
    TextStyle? headingXlRegular,
    TextStyle? headingXlMedium,
    TextStyle? headingXlSemiBold,
    TextStyle? headingXlBold,
    TextStyle? headingLRegular,
    TextStyle? headingLMedium,
    TextStyle? headingLSemiBold,
    TextStyle? headingLBold,
    TextStyle? headingMRegular,
    TextStyle? headingMMedium,
    TextStyle? headingMSemiBold,
    TextStyle? headingMBold,
    TextStyle? headingSRegular,
    TextStyle? headingSMedium,
    TextStyle? headingSSemiBold,
    TextStyle? headingSBold,
    TextStyle? headingXsRegular,
    TextStyle? headingXsMedium,
    TextStyle? headingXsSemiBold,
    TextStyle? headingXsBold,
    TextStyle? bodyXlRegular,
    TextStyle? bodyXlMedium,
    TextStyle? bodyXlSemiBold,
    TextStyle? bodyLRegular,
    TextStyle? bodyLMedium,
    TextStyle? bodyLSemiBold,
    TextStyle? bodyMRegular,
    TextStyle? bodyMMedium,
    TextStyle? bodyMSemiBold,
    TextStyle? bodySRegular,
    TextStyle? bodySMedium,
    TextStyle? bodySSemiBold,
    TextStyle? bodySsRegular,
    TextStyle? bodySsMedium,
    TextStyle? bodySsSemiBold,
    TextStyle? bodySssRegular,
    TextStyle? bodySssMedium,
    TextStyle? bodySssSemiBold,
  }) {
    return GuidelineTypography(
      headingXlRegular: headingXlRegular ?? this.headingXlRegular,
      headingXlMedium: headingXlMedium ?? this.headingXlMedium,
      headingXlSemiBold: headingXlSemiBold ?? this.headingXlSemiBold,
      headingXlBold: headingXlBold ?? this.headingXlBold,
      headingLRegular: headingLRegular ?? this.headingLRegular,
      headingLMedium: headingLMedium ?? this.headingLMedium,
      headingLSemiBold: headingLSemiBold ?? this.headingLSemiBold,
      headingLBold: headingLBold ?? this.headingLBold,
      headingMRegular: headingMRegular ?? this.headingMRegular,
      headingMMedium: headingMMedium ?? this.headingMMedium,
      headingMSemiBold: headingMSemiBold ?? this.headingMSemiBold,
      headingMBold: headingMBold ?? this.headingMBold,
      headingSRegular: headingSRegular ?? this.headingSRegular,
      headingSMedium: headingSMedium ?? this.headingSMedium,
      headingSSemiBold: headingSSemiBold ?? this.headingSSemiBold,
      headingSBold: headingSBold ?? this.headingSBold,
      headingXsRegular: headingXsRegular ?? this.headingXsRegular,
      headingXsMedium: headingXsMedium ?? this.headingXsMedium,
      headingXsSemiBold: headingXsSemiBold ?? this.headingXsSemiBold,
      headingXsBold: headingXsBold ?? this.headingXsBold,
      bodyXlRegular: bodyXlRegular ?? this.bodyXlRegular,
      bodyXlMedium: bodyXlMedium ?? this.bodyXlMedium,
      bodyXlSemiBold: bodyXlSemiBold ?? this.bodyXlSemiBold,
      bodyLRegular: bodyLRegular ?? this.bodyLRegular,
      bodyLMedium: bodyLMedium ?? this.bodyLMedium,
      bodyLSemiBold: bodyLSemiBold ?? this.bodyLSemiBold,
      bodyMRegular: bodyMRegular ?? this.bodyMRegular,
      bodyMMedium: bodyMMedium ?? this.bodyMMedium,
      bodyMSemiBold: bodyMSemiBold ?? this.bodyMSemiBold,
      bodySRegular: bodySRegular ?? this.bodySRegular,
      bodySMedium: bodySMedium ?? this.bodySMedium,
      bodySSemiBold: bodySSemiBold ?? this.bodySSemiBold,
      bodySsRegular: bodySsRegular ?? this.bodySsRegular,
      bodySsMedium: bodySsMedium ?? this.bodySsMedium,
      bodySsSemiBold: bodySsSemiBold ?? this.bodySsSemiBold,
      bodySssRegular: bodySssRegular ?? this.bodySssRegular,
      bodySssMedium: bodySssMedium ?? this.bodySssMedium,
      bodySssSemiBold: bodySssSemiBold ?? this.bodySssSemiBold,
    );
  }

  @override
  ThemeExtension<GuidelineTypography> lerp(
    covariant ThemeExtension<GuidelineTypography>? other,
    double t,
  ) {
    if (other is! GuidelineTypography) {
      return this;
    }

    TextStyle lerp(TextStyle a, TextStyle b) => TextStyle.lerp(a, b, t)!;

    return GuidelineTypography(
      headingXlRegular: lerp(headingXlRegular, other.headingXlRegular),
      headingXlMedium: lerp(headingXlMedium, other.headingXlMedium),
      headingXlSemiBold: lerp(headingXlSemiBold, other.headingXlSemiBold),
      headingXlBold: lerp(headingXlBold, other.headingXlBold),
      headingLRegular: lerp(headingLRegular, other.headingLRegular),
      headingLMedium: lerp(headingLMedium, other.headingLMedium),
      headingLSemiBold: lerp(headingLSemiBold, other.headingLSemiBold),
      headingLBold: lerp(headingLBold, other.headingLBold),
      headingMRegular: lerp(headingMRegular, other.headingMRegular),
      headingMMedium: lerp(headingMMedium, other.headingMMedium),
      headingMSemiBold: lerp(headingMSemiBold, other.headingMSemiBold),
      headingMBold: lerp(headingMBold, other.headingMBold),
      headingSRegular: lerp(headingSRegular, other.headingSRegular),
      headingSMedium: lerp(headingSMedium, other.headingSMedium),
      headingSSemiBold: lerp(headingSSemiBold, other.headingSSemiBold),
      headingSBold: lerp(headingSBold, other.headingSBold),
      headingXsRegular: lerp(headingXsRegular, other.headingXsRegular),
      headingXsMedium: lerp(headingXsMedium, other.headingXsMedium),
      headingXsSemiBold: lerp(headingXsSemiBold, other.headingXsSemiBold),
      headingXsBold: lerp(headingXsBold, other.headingXsBold),
      bodyXlRegular: lerp(bodyXlRegular, other.bodyXlRegular),
      bodyXlMedium: lerp(bodyXlMedium, other.bodyXlMedium),
      bodyXlSemiBold: lerp(bodyXlSemiBold, other.bodyXlSemiBold),
      bodyLRegular: lerp(bodyLRegular, other.bodyLRegular),
      bodyLMedium: lerp(bodyLMedium, other.bodyLMedium),
      bodyLSemiBold: lerp(bodyLSemiBold, other.bodyLSemiBold),
      bodyMRegular: lerp(bodyMRegular, other.bodyMRegular),
      bodyMMedium: lerp(bodyMMedium, other.bodyMMedium),
      bodyMSemiBold: lerp(bodyMSemiBold, other.bodyMSemiBold),
      bodySRegular: lerp(bodySRegular, other.bodySRegular),
      bodySMedium: lerp(bodySMedium, other.bodySMedium),
      bodySSemiBold: lerp(bodySSemiBold, other.bodySSemiBold),
      bodySsRegular: lerp(bodySsRegular, other.bodySsRegular),
      bodySsMedium: lerp(bodySsMedium, other.bodySsMedium),
      bodySsSemiBold: lerp(bodySsSemiBold, other.bodySsSemiBold),
      bodySssRegular: lerp(bodySssRegular, other.bodySssRegular),
      bodySssMedium: lerp(bodySssMedium, other.bodySssMedium),
      bodySssSemiBold: lerp(bodySssSemiBold, other.bodySssSemiBold),
    );
  }
}
