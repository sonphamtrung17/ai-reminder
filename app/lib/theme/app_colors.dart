import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xFF000000);

  static const Color primary = Color(0xff252C6D);
  static const Color secondary = Color(0xFFF9AA33);

  static const Color blue = Color(0xFF3872FF);
  static const Color cyan = Color(0xFF00CAA1);
  static const Color green = Color(0xFF07C160);
  static const Color yellow = Color(0xFFFAAB0C);
  static const Color red = Color(0xFFEE0A24);

  static const Color gray1 = Color(0xFFF5F5F5);
  static const Color gray2 = Color(0xFFE4E4E7);
  static const Color gray3 = Color(0xFFD4D4D8);
  static const Color gray4 = Color(0xFFBFBFC2);
  static const Color gray5 = Color(0xFFA1A1AA);
  static const Color gray6 = Color(0xFF71717A);
  static const Color gray7 = Color(0xFF52525B);
  static const Color gray8 = Color(0xFF3F3F46);
  static const Color gray9 = Color(0xFF27272A);
  static const Color gray10 = Color(0xFF151517);

  static const Color danger = Color(0xFFEE0A24);
  static const Color success = Color(0xFF07C160);
  static const Color warning = Color(0xFFFF9F0A);
  static const Color border = Color(0xFFEDEDED);
  static const Color background = Color(0xFFF7F8FA);
  static const Color background2 = Color(0xFFF5F5F5);
  static const Color background3 = Color(0xffeaeeff);

  static const Color buttonColor = Color(0xff252C6D);

  static List<BoxShadow> buttonShadows = [
    BoxShadow(
      color: const Color(0xFF252C6D).withValues(alpha: 0.24),
      offset: const Offset(0, 2),
      blurRadius: 3,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: const Color(0xFF252C6D).withValues(alpha: 0.24),
      offset: const Offset(0, 6),
      blurRadius: 10,
      spreadRadius: 4,
    ),
  ];
}
