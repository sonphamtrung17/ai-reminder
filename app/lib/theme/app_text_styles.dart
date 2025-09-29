import 'package:flutter/material.dart';

import 'theme.dart';

/// AppTextStyle format as follows:
/// s[fontSize][Color] or [Color]
/// Example: s18Primary or primary

extension TextStyleExtension on TextStyle {
  TextStyle white(BuildContext context, {double? fontSize}) =>
      merge(TextStyle(fontSize: fontSize, color: context.color.white));

  TextStyle black(BuildContext context, {double? fontSize}) =>
      merge(TextStyle(fontSize: fontSize, color: context.color.black));
  TextStyle black(BuildContext context, {double? fontSize, FontWeight? fontWeight}) =>
      merge(TextStyle(fontSize: fontSize, color: context.color.black, fontWeight: fontWeight));

  TextStyle red(BuildContext context, {double? fontSize, FontWeight? fontWeight}) =>
      merge(TextStyle(fontSize: fontSize, color: context.color.red));

  TextStyle white(BuildContext context, {double? fontSize}) =>
      merge(TextStyle(fontSize: fontSize, color: context.color.white));

  TextStyle primary(BuildContext context, {double? fontSize}) =>
      merge(TextStyle(fontSize: fontSize, color: context.color.primary));

  TextStyle gray5(BuildContext context, {double? fontSize}) =>
      merge(TextStyle(fontSize: fontSize, color: context.color.gray5));

  TextStyle gray6(BuildContext context, {double? fontSize}) =>
      merge(TextStyle(fontSize: fontSize, color: context.color.gray6));

  TextStyle gray7(BuildContext context, {double? fontSize}) =>
      merge(TextStyle(fontSize: fontSize, color: context.color.gray7));

  TextStyle gray8(BuildContext context, {double? fontSize}) =>
      merge(TextStyle(fontSize: fontSize, color: context.color.gray8));

  TextStyle gray(BuildContext context, {Color?  color, double? fontSize, FontWeight? fontWeight}) => merge(
    TextStyle(
      fontSize: fontSize,
      color: color ?? context.color.gray1,
      fontWeight: fontWeight ?? FontWeight.w500,
    ),
  );

  TextStyle gray5(BuildContext context, {double? fontSize}) =>
      merge(TextStyle(fontSize: fontSize, color: context.color.gray5));

  TextStyle gray9(BuildContext context, {double? fontSize}) =>
      merge(TextStyle(fontSize: fontSize, color: context.color.gray9));

  TextStyle blue(BuildContext context, {double? fontSize}) =>
      merge(TextStyle(fontSize: fontSize, color: context.color.blue));
}
