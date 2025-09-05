import 'package:flutter/material.dart';

class GuidelineColor extends ThemeExtension<GuidelineColor> {
  final Color white;
  final Color black;
  final Color primary;
  final Color secondary;
  final Color blue;
  final Color cyan;
  final Color green;
  final Color yellow;
  final Color red;
  final Color gray1;
  final Color gray2;
  final Color gray3;
  final Color gray4;
  final Color gray5;
  final Color gray6;
  final Color gray7;
  final Color gray8;
  final Color gray9;
  final Color gray10;
  final Color danger;
  final Color success;
  final Color warning;
  final Color border;
  final Color background;
  final Color background2;

  const GuidelineColor({
    required this.white,
    required this.black,
    required this.primary,
    required this.secondary,
    required this.blue,
    required this.cyan,
    required this.green,
    required this.yellow,
    required this.red,
    required this.gray1,
    required this.gray2,
    required this.gray3,
    required this.gray4,
    required this.gray5,
    required this.gray6,
    required this.gray7,
    required this.gray8,
    required this.gray9,
    required this.gray10,
    required this.danger,
    required this.success,
    required this.warning,
    required this.border,
    required this.background,
    required this.background2,
  });

  @override
  ThemeExtension<GuidelineColor> lerp(
    covariant ThemeExtension<GuidelineColor>? other,
    double t,
  ) {
    if (other is! GuidelineColor) {
      return this;
    }

    Color lerp(Color x, Color y, double t) => Color.lerp(x, y, t)!;

    return GuidelineColor(
      white: lerp(white, other.white, t),
      black: lerp(black, other.black, t),
      primary: lerp(primary, other.primary, t),
      secondary: lerp(secondary, other.secondary, t),
      blue: lerp(blue, other.blue, t),
      cyan: lerp(cyan, other.cyan, t),
      green: lerp(green, other.green, t),
      yellow: lerp(yellow, other.yellow, t),
      red: lerp(red, other.red, t),
      gray1: lerp(gray1, other.gray1, t),
      gray2: lerp(gray2, other.gray2, t),
      gray3: lerp(gray3, other.gray3, t),
      gray4: lerp(gray4, other.gray4, t),
      gray5: lerp(gray5, other.gray5, t),
      gray6: lerp(gray6, other.gray6, t),
      gray7: lerp(gray7, other.gray7, t),
      gray8: lerp(gray8, other.gray8, t),
      gray9: lerp(gray9, other.gray9, t),
      gray10: lerp(gray10, other.gray10, t),
      danger: lerp(danger, other.danger, t),
      success: lerp(success, other.success, t),
      warning: lerp(warning, other.warning, t),
      border: lerp(border, other.border, t),
      background: lerp(background, other.background, t),
      background2: lerp(background2, other.background2, t),
    );
  }

  @override
  ThemeExtension<GuidelineColor> copyWith({
    Color? white,
    Color? black,
    Color? primary,
    Color? secondary,
    Color? blue,
    Color? cyan,
    Color? green,
    Color? yellow,
    Color? red,
    Color? gray1,
    Color? gray2,
    Color? gray3,
    Color? gray4,
    Color? gray5,
    Color? gray6,
    Color? gray7,
    Color? gray8,
    Color? gray9,
    Color? gray10,
    Color? danger,
    Color? success,
    Color? warning,
    Color? border,
    Color? background,
    Color? background2,
  }) {
    return GuidelineColor(
      white: white ?? this.white,
      black: black ?? this.black,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      blue: blue ?? this.blue,
      cyan: cyan ?? this.cyan,
      green: green ?? this.green,
      yellow: yellow ?? this.yellow,
      red: red ?? this.red,
      gray1: gray1 ?? this.gray1,
      gray2: gray2 ?? this.gray2,
      gray3: gray3 ?? this.gray3,
      gray4: gray4 ?? this.gray4,
      gray5: gray5 ?? this.gray5,
      gray6: gray6 ?? this.gray6,
      gray7: gray7 ?? this.gray7,
      gray8: gray8 ?? this.gray8,
      gray9: gray9 ?? this.gray9,
      gray10: gray10 ?? this.gray10,
      danger: danger ?? this.danger,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      border: border ?? this.border,
      background: background ?? this.background,
      background2: background2 ?? this.background2,
    );
  }
}
