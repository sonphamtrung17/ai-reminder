import 'package:flutter/material.dart';

import 'theme.dart';

class GuidelineTextStyle {
  static const _defaultLetterSpacing = 0.15;

  static const _baseTextStyle = TextStyle(letterSpacing: _defaultLetterSpacing);

  // ===== Heading XL (36px) =====
  static final headingXlRegular = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d36,
      height: Dimens.d44 / Dimens.d36,
      fontWeight: FontWeight.w400,
    ),
  );
  static final headingXlMedium = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d36,
      height: Dimens.d44 / Dimens.d36,
      fontWeight: FontWeight.w500,
    ),
  );
  static final headingXlSemiBold = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d36,
      height: Dimens.d44 / Dimens.d36,
      fontWeight: FontWeight.w600,
    ),
  );
  static final headingXlBold = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d36,
      height: Dimens.d44 / Dimens.d36,
      fontWeight: FontWeight.w700,
    ),
  );

  // ===== Heading L (32px) =====
  static final headingLRegular = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d32,
      height: Dimens.d40 / Dimens.d32,
      fontWeight: FontWeight.w400,
    ),
  );
  static final headingLMedium = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d32,
      height: Dimens.d40 / Dimens.d32,
      fontWeight: FontWeight.w500,
    ),
  );
  static final headingLSemiBold = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d32,
      height: Dimens.d40 / Dimens.d32,
      fontWeight: FontWeight.w600,
    ),
  );
  static final headingLBold = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d32,
      height: Dimens.d40 / Dimens.d32,
      fontWeight: FontWeight.w700,
    ),
  );

  // ===== Heading M (28px) =====
  static final headingMRegular = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d28,
      height: Dimens.d36 / Dimens.d28,
      fontWeight: FontWeight.w400,
    ),
  );
  static final headingMMedium = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d28,
      height: Dimens.d36 / Dimens.d28,
      fontWeight: FontWeight.w500,
    ),
  );
  static final headingMSemiBold = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d28,
      height: Dimens.d36 / Dimens.d28,
      fontWeight: FontWeight.w600,
    ),
  );
  static final headingMBold = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d28,
      height: Dimens.d36 / Dimens.d28,
      fontWeight: FontWeight.w700,
    ),
  );

  // ===== Heading S (24px) =====
  static final headingSRegular = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d24,
      height: Dimens.d32 / Dimens.d24,
      fontWeight: FontWeight.w400,
    ),
  );
  static final headingSMedium = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d24,
      height: Dimens.d32 / Dimens.d24,
      fontWeight: FontWeight.w500,
    ),
  );
  static final headingSSemiBold = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d24,
      height: Dimens.d32 / Dimens.d24,
      fontWeight: FontWeight.w600,
    ),
  );
  static final headingSBold = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d24,
      height: Dimens.d32 / Dimens.d24,
      fontWeight: FontWeight.w700,
    ),
  );

  // ===== Heading XS (20px) =====
  static final headingXsRegular = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d20,
      height: Dimens.d32 / Dimens.d20,
      fontWeight: FontWeight.w400,
    ),
  );
  static final headingXsMedium = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d20,
      height: Dimens.d32 / Dimens.d20,
      fontWeight: FontWeight.w500,
    ),
  );
  static final headingXsSemiBold = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d20,
      height: Dimens.d32 / Dimens.d20,
      fontWeight: FontWeight.w600,
    ),
  );
  static final headingXsBold = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d20,
      height: Dimens.d32 / Dimens.d20,
      fontWeight: FontWeight.w700,
    ),
  );

  // ===== Body XL (18px) =====
  static final bodyXlRegular = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d18,
      height: Dimens.d28 / Dimens.d18,
      fontWeight: FontWeight.w400,
    ),
  );
  static final bodyXlMedium = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d18,
      height: Dimens.d28 / Dimens.d18,
      fontWeight: FontWeight.w500,
    ),
  );
  static final bodyXlSemiBold = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d18,
      height: Dimens.d28 / Dimens.d18,
      fontWeight: FontWeight.w600,
    ),
  );

  // ===== Body L (16px) =====
  static final bodyLRegular = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d16,
      height: Dimens.d24 / Dimens.d16,
      fontWeight: FontWeight.w400,
    ),
  );
  static final bodyLMedium = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d16,
      height: Dimens.d24 / Dimens.d16,
      fontWeight: FontWeight.w500,
    ),
  );
  static final bodyLSemiBold = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d16,
      height: Dimens.d24 / Dimens.d16,
      fontWeight: FontWeight.w600,
    ),
  );

  // ===== Body M (14px) =====
  static final bodyMRegular = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d14,
      height: Dimens.d20 / Dimens.d14,
      fontWeight: FontWeight.w400,
    ),
  );
  static final bodyMMedium = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d14,
      height: Dimens.d20 / Dimens.d14,
      fontWeight: FontWeight.w500,
    ),
  );
  static final bodyMSemiBold = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d14,
      height: Dimens.d20 / Dimens.d14,
      fontWeight: FontWeight.w600,
    ),
  );

  // ===== Body S (12px) =====
  static final bodySRegular = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d12,
      height: Dimens.d18 / Dimens.d12,
      fontWeight: FontWeight.w400,
    ),
  );
  static final bodySMedium = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d12,
      height: Dimens.d18 / Dimens.d12,
      fontWeight: FontWeight.w500,
    ),
  );
  static final bodySSemiBold = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d12,
      height: Dimens.d18 / Dimens.d12,
      fontWeight: FontWeight.w600,
    ),
  );

  // ===== Body SS (10px) =====
  static final bodySSRegular = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d10,
      height: Dimens.d15 / Dimens.d10,
      fontWeight: FontWeight.w400,
    ),
  );
  static final bodySSMedium = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d10,
      height: Dimens.d15 / Dimens.d10,
      fontWeight: FontWeight.w500,
    ),
  );
  static final bodySSSemiBold = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d10,
      height: Dimens.d15 / Dimens.d10,
      fontWeight: FontWeight.w600,
    ),
  );

  // ===== Body SSS (8px) =====
  static final bodySSSRegular = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d8,
      height: Dimens.d12 / Dimens.d8,
      fontWeight: FontWeight.w400,
    ),
  );
  static final bodySSSMedium = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d8,
      height: Dimens.d12 / Dimens.d8,
      fontWeight: FontWeight.w500,
    ),
  );
  static final bodySSSSemiBold = _baseTextStyle.merge(
    const TextStyle(
      fontSize: Dimens.d8,
      height: Dimens.d12 / Dimens.d8,
      fontWeight: FontWeight.w600,
    ),
  );
}
