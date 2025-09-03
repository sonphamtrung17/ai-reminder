import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_popup_info.freezed.dart';

@freezed
sealed class AppPopupInfo with _$AppPopupInfo {
  const factory AppPopupInfo.confirmDialog({
    @Default('') String message,
    Function? onPressed,
  }) = _ConfirmDialog;

  const factory AppPopupInfo.errorWithRetryDialog({
    @Default('') String message,
    Function? onRetryPressed,
  }) = _ErrorWithRetryDialog;
}