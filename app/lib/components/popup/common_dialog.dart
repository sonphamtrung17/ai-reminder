import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translate/translate.dart';

import '../../theme/theme.dart';
import 'popup_button.dart';

enum PopupType { android, ios, adaptive }

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    this.commonPopupType = PopupType.adaptive,
    this.actions = const <PopupButton>[],
    this.title,
    this.message,
    super.key,
  });

  const CommonDialog.android({
    List<PopupButton> actions = const <PopupButton>[],
    String? title,
    String? message,
    Key? key,
  }) : this(
         commonPopupType: PopupType.android,
         actions: actions,
         title: title,
         message: message,
         key: key,
       );

  const CommonDialog.ios({
    List<PopupButton> actions = const <PopupButton>[],
    String? title,
    String? message,
    Key? key,
  }) : this(
         commonPopupType: PopupType.ios,
         actions: actions,
         title: title,
         message: message,
         key: key,
       );

  const CommonDialog.adaptive({
    List<PopupButton> actions = const <PopupButton>[],
    String? title,
    String? message,
    Key? key,
  }) : this(
         commonPopupType: PopupType.adaptive,
         actions: actions,
         title: title,
         message: message,
         key: key,
       );

  final PopupType commonPopupType;
  final List<PopupButton> actions;
  final String? title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    switch (commonPopupType) {
      case PopupType.android:
        return _buildAndroidDialog(context);
      case PopupType.ios:
        return _buildIosDialog(context);
      case PopupType.adaptive:
        return Platform.isIOS ? _buildIosDialog(context) : _buildAndroidDialog(context);
    }
  }

  Widget _buildAndroidDialog(BuildContext context) {
    return AlertDialog(
      actions: actions
          .map(
            (e) => TextButton(
              onPressed: () => e.onPressed?.call(),
              child: Text(
                e.text ?? S.current.ok,
                style: e.isDefault
                    ? context.textStyle.bodySMedium.black(context)
                    : context.textStyle.bodySMedium.copyWith(
                        color: context.color.primary,
                      ),
              ),
            ),
          )
          .toList(growable: false),
      title: title != null
          ? Text(
              title ?? '',
              style: context.textStyle.bodySMedium.copyWith(
                color: context.color.primary,
              ),
            )
          : null,
      content: message != null
          ? Text(
              message ?? '',
              style: context.textStyle.bodySMedium.copyWith(
                color: context.color.primary,
              ),
            )
          : null,
    );
  }

  Widget _buildIosDialog(BuildContext context) {
    return CupertinoAlertDialog(
      actions: actions
          .map(
            (e) => CupertinoDialogAction(
              onPressed: () => e.onPressed?.call(),
              child: Text(
                e.text ?? S.current.ok,
                style: e.isDefault
                    ? context.textStyle.bodySMedium.copyWith(
                        color: context.color.secondary,
                      )
                    : context.textStyle.bodySMedium.copyWith(
                        color: context.color.primary,
                      ),
              ),
            ),
          )
          .toList(growable: false),
      title: title != null
          ? Text(
              title ?? '',
              style: context.textStyle.bodySMedium.copyWith(
                color: context.color.primary,
              ),
            )
          : null,
      content: message != null
          ? Text(
              message ?? '',
              style: context.textStyle.bodySMedium.copyWith(
                color: context.color.primary,
              ),
            )
          : null,
    );
  }
}
