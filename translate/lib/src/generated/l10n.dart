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

  /// `Xin chào! Hôm nay bạn thế nào?`
  String get xinChaoHomNayBanTheNao {
    return Intl.message(
      'Xin chào! Hôm nay bạn thế nào?',
      name: 'xinChaoHomNayBanTheNao',
      desc: '',
      args: [],
    );
  }

  /// `Sự kiện sắp diễn ra`
  String get suKienSapDienRa {
    return Intl.message(
      'Sự kiện sắp diễn ra',
      name: 'suKienSapDienRa',
      desc: '',
      args: [],
    );
  }

  /// `Sinh nhật`
  String get sinhNhat {
    return Intl.message('Sinh nhật', name: 'sinhNhat', desc: '', args: []);
  }

  /// `Ngày lễ sắp đến`
  String get ngayLeSapDen {
    return Intl.message(
      'Ngày lễ sắp đến',
      name: 'ngayLeSapDen',
      desc: '',
      args: [],
    );
  }

  /// `ngày`
  String get ngay {
    return Intl.message('ngày', name: 'ngay', desc: '', args: []);
  }

  /// `Đã tạo bởi bạn`
  String get daTaoBoiBan {
    return Intl.message(
      'Đã tạo bởi bạn',
      name: 'daTaoBoiBan',
      desc: '',
      args: [],
    );
  }

  /// `Đối tượng quan tâm`
  String get doiTuongQuanTam {
    return Intl.message(
      'Đối tượng quan tâm',
      name: 'doiTuongQuanTam',
      desc: '',
      args: [],
    );
  }

  /// `Tạo`
  String get tao {
    return Intl.message('Tạo', name: 'tao', desc: '', args: []);
  }

  /// `Chọn kiểu ảnh`
  String get chonKieuAnh {
    return Intl.message(
      'Chọn kiểu ảnh',
      name: 'chonKieuAnh',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message('Camera', name: 'camera', desc: '', args: []);
  }

  /// `Photo gallery`
  String get photoGallery {
    return Intl.message(
      'Photo gallery',
      name: 'photoGallery',
      desc: '',
      args: [],
    );
  }

  /// `Tạo đối tượng`
  String get taoDoiTuong {
    return Intl.message(
      'Tạo đối tượng',
      name: 'taoDoiTuong',
      desc: '',
      args: [],
    );
  }

  /// `Họ và tên`
  String get hoVaTen {
    return Intl.message('Họ và tên', name: 'hoVaTen', desc: '', args: []);
  }

  /// `Vui lòng nhập tên`
  String get vuiLongNhapTen {
    return Intl.message(
      'Vui lòng nhập tên',
      name: 'vuiLongNhapTen',
      desc: '',
      args: [],
    );
  }

  /// `Nam`
  String get nam {
    return Intl.message('Nam', name: 'nam', desc: '', args: []);
  }

  /// `Nữ`
  String get nu {
    return Intl.message('Nữ', name: 'nu', desc: '', args: []);
  }

  /// `Ngày sinh`
  String get ngaySinh {
    return Intl.message('Ngày sinh', name: 'ngaySinh', desc: '', args: []);
  }

  /// `Mối quan hệ`
  String get moiQuanHe {
    return Intl.message('Mối quan hệ', name: 'moiQuanHe', desc: '', args: []);
  }

  /// `Nghề nghiệp`
  String get ngheNghiep {
    return Intl.message('Nghề nghiệp', name: 'ngheNghiep', desc: '', args: []);
  }

  /// `Số điện thoại`
  String get soDienThoai {
    return Intl.message(
      'Số điện thoại',
      name: 'soDienThoai',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Địa chỉ`
  String get diaChi {
    return Intl.message('Địa chỉ', name: 'diaChi', desc: '', args: []);
  }

  /// `Ghi chú`
  String get ghiChu {
    return Intl.message('Ghi chú', name: 'ghiChu', desc: '', args: []);
  }

  /// `Thông báo`
  String get thongBao {
    return Intl.message('Thông báo', name: 'thongBao', desc: '', args: []);
  }

  /// `Năm`
  String get year {
    return Intl.message('Năm', name: 'year', desc: '', args: []);
  }

  /// `Tháng`
  String get thang {
    return Intl.message('Tháng', name: 'thang', desc: '', args: []);
  }

  /// `Tuần`
  String get tuan {
    return Intl.message('Tuần', name: 'tuan', desc: '', args: []);
  }

  /// `Tất cả`
  String get tatCa {
    return Intl.message('Tất cả', name: 'tatCa', desc: '', args: []);
  }

  /// `Lưu lại`
  String get luuLai {
    return Intl.message('Lưu lại', name: 'luuLai', desc: '', args: []);
  }

  /// `Các sự kiện trong ngày`
  String get cacSuKienTrongNgay {
    return Intl.message(
      'Các sự kiện trong ngày',
      name: 'cacSuKienTrongNgay',
      desc: '',
      args: [],
    );
  }

  /// `Gợi ý từ AI`
  String get goiYTuAI {
    return Intl.message('Gợi ý từ AI', name: 'goiYTuAI', desc: '', args: []);
  }

  /// `Nhân bản`
  String get nhanBan {
    return Intl.message('Nhân bản', name: 'nhanBan', desc: '', args: []);
  }

  /// `Chỉnh sửa`
  String get chinhSua {
    return Intl.message('Chỉnh sửa', name: 'chinhSua', desc: '', args: []);
  }

  /// `Xoá`
  String get xoa {
    return Intl.message('Xoá', name: 'xoa', desc: '', args: []);
  }

  /// `Chưa có thông báo`
  String get chuaCoThongBao {
    return Intl.message(
      'Chưa có thông báo',
      name: 'chuaCoThongBao',
      desc: '',
      args: [],
    );
  }

  /// `Các thông báo mới sẽ xuất hiện ở đây`
  String get cacThongBaoMoiNhatSeXuatHienOday {
    return Intl.message(
      'Các thông báo mới sẽ xuất hiện ở đây',
      name: 'cacThongBaoMoiNhatSeXuatHienOday',
      desc: '',
      args: [],
    );
  }

  /// `Chưa có sự kiện nào`
  String get chuaCoSuKienNao {
    return Intl.message(
      'Chưa có sự kiện nào',
      name: 'chuaCoSuKienNao',
      desc: '',
      args: [],
    );
  }

  /// `Sự kiện mới`
  String get suKienMoi {
    return Intl.message('Sự kiện mới', name: 'suKienMoi', desc: '', args: []);
  }

  /// `Tiêu đề sự kiện`
  String get tieuDeSuKien {
    return Intl.message(
      'Tiêu đề sự kiện',
      name: 'tieuDeSuKien',
      desc: '',
      args: [],
    );
  }

  /// `Loại sự kiện`
  String get loaiSuKien {
    return Intl.message('Loại sự kiện', name: 'loaiSuKien', desc: '', args: []);
  }

  /// `Thời gian`
  String get thoiGian {
    return Intl.message('Thời gian', name: 'thoiGian', desc: '', args: []);
  }

  /// `Ngày`
  String get ngayEvent {
    return Intl.message('Ngày', name: 'ngayEvent', desc: '', args: []);
  }

  /// `Giờ`
  String get gio {
    return Intl.message('Giờ', name: 'gio', desc: '', args: []);
  }

  /// `Đối tượng`
  String get doiTuong {
    return Intl.message('Đối tượng', name: 'doiTuong', desc: '', args: []);
  }

  /// `Không lặp lại`
  String get khongLapLai {
    return Intl.message(
      'Không lặp lại',
      name: 'khongLapLai',
      desc: '',
      args: [],
    );
  }

  /// `Nhập sở thích, mô tả hoặc tính cách đối tượng`
  String get nhapSoThich {
    return Intl.message(
      'Nhập sở thích, mô tả hoặc tính cách đối tượng',
      name: 'nhapSoThich',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận`
  String get xacNhan {
    return Intl.message('Xác nhận', name: 'xacNhan', desc: '', args: []);
  }

  /// `Lặp lại`
  String get lapLai {
    return Intl.message('Lặp lại', name: 'lapLai', desc: '', args: []);
  }

  /// `Hàng ngày`
  String get hangNgay {
    return Intl.message('Hàng ngày', name: 'hangNgay', desc: '', args: []);
  }

  /// `Hàng tuần`
  String get hangTuan {
    return Intl.message('Hàng tuần', name: 'hangTuan', desc: '', args: []);
  }

  /// `Hàng tháng`
  String get hangThang {
    return Intl.message('Hàng tháng', name: 'hangThang', desc: '', args: []);
  }

  /// `Hàng năm`
  String get hangNam {
    return Intl.message('Hàng năm', name: 'hangNam', desc: '', args: []);
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
