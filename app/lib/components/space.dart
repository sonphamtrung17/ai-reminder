import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  final double? width;
  final double? height;

  const Space({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height);
  }

  factory Space.w4() => const Space(width: 4);

  factory Space.w5() => const Space(width: 5);

  factory Space.w6() => const Space(width: 6);

  factory Space.w8() => const Space(width: 8);

  factory Space.w10() => const Space(width: 10);

  factory Space.w12() => const Space(width: 12);

  factory Space.w14() => const Space(width: 14);

  factory Space.w16() => const Space(width: 16);

  factory Space.w18() => const Space(width: 18);

  factory Space.w20() => const Space(width: 20);

  factory Space.w24() => const Space(width: 24);

  factory Space.w2() => const Space(width: 2);

  factory Space.w36() => const Space(width: 36);

  factory Space.h1() => const Space(height: 1);

  factory Space.h2() => const Space(height: 2);

  factory Space.h4() => const Space(height: 4);

  factory Space.h5() => const Space(height: 5);

  factory Space.h6() => const Space(height: 6);

  factory Space.h8() => const Space(height: 8);

  factory Space.h10() => const Space(height: 10);

  factory Space.h12() => const Space(height: 12);

  factory Space.h14() => const Space(height: 14);

  factory Space.h16() => const Space(height: 16);

  factory Space.h18() => const Space(height: 18);

  factory Space.h17() => const Space(height: 17);

  factory Space.h20() => const Space(height: 20);

  factory Space.h24() => const Space(height: 24);

  factory Space.h28() => const Space(height: 28);

  factory Space.h30() => const Space(height: 30);

  factory Space.h60() => const Space(height: 60);

  factory Space.h80() => const Space(height: 80);

  factory Space.h88() => const Space(height: 88);

  factory Space.h32() => const Space(height: 32);

  factory Space.h36() => const Space(height: 36);

  factory Space.h40() => const Space(height: 40);

  factory Space.h50() => const Space(height: 50);

  factory Space.h48() => const Space(height: 48);

  factory Space.h64() => const Space(height: 64);

  factory Space.h100() => const Space(height: 100);

  factory Space.h67() => const Space(height: 67);
}
