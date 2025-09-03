import 'package:shared/shared.dart';

enum LanguageCode {
  en(localeCode: 'en'),
  vi(localeCode: 'vi');

  const LanguageCode({required this.localeCode});

  final String localeCode;

  static const defaultValue = vi;

  static LanguageCode fromLocaleCode(String localeCode) {
    return LanguageCode.values.firstWhere(
      (element) => element.localeCode == localeCode,
      orElse: () => defaultValue,
    );
  }
}

enum Gender {
  male(ServerRequestResponseConstants.male),
  female(ServerRequestResponseConstants.female),
  other(ServerRequestResponseConstants.other),
  unknown(ServerRequestResponseConstants.unknown);

  const Gender(this.serverValue);

  final int serverValue;

  static const defaultValue = unknown;
}
