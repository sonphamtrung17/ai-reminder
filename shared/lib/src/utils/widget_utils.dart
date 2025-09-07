import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget wrapPadding(EdgeInsetsGeometry padding) {
    return Padding(padding: padding, child: this);
  }
}
