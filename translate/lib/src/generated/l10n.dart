// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `unknownException ({errorCode})`
  String unknownException(Object errorCode) {
    return Intl.message(
      'unknownException ($errorCode)',
      name: 'unknownException',
      desc: '',
      args: [errorCode],
    );
  }

  /// `parseException`
  String get parseException {
    return Intl.message(
      'parseException',
      name: 'parseException',
      desc: '',
      args: [],
    );
  }

  /// `cancellationException`
  String get cancellationException {
    return Intl.message(
      'cancellationException',
      name: 'cancellationException',
      desc: '',
      args: [],
    );
  }

  /// `noInternetException`
  String get noInternetException {
    return Intl.message(
      'noInternetException',
      name: 'noInternetException',
      desc: '',
      args: [],
    );
  }

  /// `timeoutException`
  String get timeoutException {
    return Intl.message(
      'timeoutException',
      name: 'timeoutException',
      desc: '',
      args: [],
    );
  }

  /// `badCertificateException`
  String get badCertificateException {
    return Intl.message(
      'badCertificateException',
      name: 'badCertificateException',
      desc: '',
      args: [],
    );
  }

  /// `Can not connect to this host`
  String get canNotConnectToHost {
    return Intl.message(
      'Can not connect to this host',
      name: 'canNotConnectToHost',
      desc: '',
      args: [],
    );
  }

  /// `tokenExpired`
  String get tokenExpired {
    return Intl.message(
      'tokenExpired',
      name: 'tokenExpired',
      desc: '',
      args: [],
    );
  }

  /// `emptyEmail`
  String get emptyEmail {
    return Intl.message('emptyEmail', name: 'emptyEmail', desc: '', args: []);
  }

  /// `invalidEmail`
  String get invalidEmail {
    return Intl.message(
      'invalidEmail',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `invalidPassword`
  String get invalidPassword {
    return Intl.message(
      'invalidPassword',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `invalidUserName`
  String get invalidUserName {
    return Intl.message(
      'invalidUserName',
      name: 'invalidUserName',
      desc: '',
      args: [],
    );
  }

  /// `invalidPhoneNumber`
  String get invalidPhoneNumber {
    return Intl.message(
      'invalidPhoneNumber',
      name: 'invalidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `invalidDateTime`
  String get invalidDateTime {
    return Intl.message(
      'invalidDateTime',
      name: 'invalidDateTime',
      desc: '',
      args: [],
    );
  }

  /// `passwordsAreNotMatch`
  String get passwordsAreNotMatch {
    return Intl.message(
      'passwordsAreNotMatch',
      name: 'passwordsAreNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Huỷ bỏ`
  String get cancel {
    return Intl.message('Huỷ bỏ', name: 'cancel', desc: '', args: []);
  }

  /// `Thử lại`
  String get retry {
    return Intl.message('Thử lại', name: 'retry', desc: '', args: []);
  }

  /// `H-AI Reminder`
  String get hAIReminder {
    return Intl.message(
      'H-AI Reminder',
      name: 'hAIReminder',
      desc: '',
      args: [],
    );
  }

  /// `Nhắc nhở ngày sinh, ngày kỉ niệm, sự kiện, thông tin khách hàng, và nhiều hơn thế.`
  String get nhacNhoNgaySinh {
    return Intl.message(
      'Nhắc nhở ngày sinh, ngày kỉ niệm, sự kiện, thông tin khách hàng, và nhiều hơn thế.',
      name: 'nhacNhoNgaySinh',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập`
  String get dangNhap {
    return Intl.message('Đăng nhập', name: 'dangNhap', desc: '', args: []);
  }

  /// `Nhắc bạn ngày đặc biệt`
  String get nhacBanNgayDacBiet {
    return Intl.message(
      'Nhắc bạn ngày đặc biệt',
      name: 'nhacBanNgayDacBiet',
      desc: '',
      args: [],
    );
  }

  /// `Giúp bạn không quên những ngày kỉ niệm với gia đình, bạn bè, những sự kiện quan trọng của BU`
  String get giupBanKhongQuen {
    return Intl.message(
      'Giúp bạn không quên những ngày kỉ niệm với gia đình, bạn bè, những sự kiện quan trọng của BU',
      name: 'giupBanKhongQuen',
      desc: '',
      args: [],
    );
  }

  /// `Nhắc nhở sự kiện, gợi ý công việc cần chuẩn bị.`
  String get nhacNhoSuKien {
    return Intl.message(
      'Nhắc nhở sự kiện, gợi ý công việc cần chuẩn bị.',
      name: 'nhacNhoSuKien',
      desc: '',
      args: [],
    );
  }

  /// `Xin chào !`
  String get xinChao {
    return Intl.message('Xin chào !', name: 'xinChao', desc: '', args: []);
  }

  /// `Hãy ghi lại, ghi nhớ và trân trọng những khoảnh khắc ý nghĩa.`
  String get hayGhiLai {
    return Intl.message(
      'Hãy ghi lại, ghi nhớ và trân trọng những khoảnh khắc ý nghĩa.',
      name: 'hayGhiLai',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu`
  String get matKhau {
    return Intl.message('Mật khẩu', name: 'matKhau', desc: '', args: []);
  }

  /// `Hoặc`
  String get hoac {
    return Intl.message('Hoặc', name: 'hoac', desc: '', args: []);
  }

  /// `Bằng việc sử dụng H-AI Reminder, bạn đồng ý với `
  String get bangViecSuDung {
    return Intl.message(
      'Bằng việc sử dụng H-AI Reminder, bạn đồng ý với ',
      name: 'bangViecSuDung',
      desc: '',
      args: [],
    );
  }

  /// `Điều khoản dịch vụ của chúng tôi.`
  String get dieuKhoanDichVu {
    return Intl.message(
      'Điều khoản dịch vụ của chúng tôi.',
      name: 'dieuKhoanDichVu',
      desc: '',
      args: [],
    );
  }

  /// `Trang chủ`
  String get trangChu {
    return Intl.message('Trang chủ', name: 'trangChu', desc: '', args: []);
  }

  /// `Lịch`
  String get lich {
    return Intl.message('Lịch', name: 'lich', desc: '', args: []);
  }

  /// `Tin nhắn`
  String get tinNhan {
    return Intl.message('Tin nhắn', name: 'tinNhan', desc: '', args: []);
  }

  /// `Cài đặt`
  String get caiDat {
    return Intl.message('Cài đặt', name: 'caiDat', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
