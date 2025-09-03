import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:translate/translate.dart';

import '../../components/popup/common_dialog.dart';
import '../../components/popup/popup_button.dart';

@LazySingleton(as: BasePopupInfoMapper)
class AppPopupInfoMapper extends BasePopupInfoMapper {
  @override
  Widget map(AppPopupInfo appRouteInfo, AppNavigator navigator) {
    return appRouteInfo.when(
      confirmDialog: (message, onPressed) {
        return CommonDialog(
          actions: [
            PopupButton(
              text: S.current.ok,
              onPressed: onPressed ?? () => navigator.pop(),
            ),
          ],
          message: message,
        );
      },
      errorWithRetryDialog: (message, onRetryPressed) {
        return CommonDialog(
          actions: [
            PopupButton(
              text: S.current.cancel,
              onPressed: () => navigator.pop(),
            ),
            PopupButton(
              text: S.current.retry,
              onPressed: onRetryPressed ?? () => navigator.pop(),
              isDefault: true,
            ),
          ],
          message: message,
        );
      },
    );
  }
}

abstract class BasePopupInfoMapper {
  Widget map(AppPopupInfo appRouteInfo, AppNavigator navigator);
}
