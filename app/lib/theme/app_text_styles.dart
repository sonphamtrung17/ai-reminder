import 'package:flutter/material.dart';

import 'theme.dart';

/// AppTextStyle format as follows:
/// s[fontSize][Color] or [Color]
/// Example: s18Primary or primary

extension TextStyleExtension on TextStyle {
  TextStyle black(BuildContext context, {double? fontSize}) =>
      merge(TextStyle(fontSize: fontSize, color: context.color.black));
}
