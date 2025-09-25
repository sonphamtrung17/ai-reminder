import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../resource/resource.dart';
import '../theme/theme.dart';
import 'components.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final List<Widget>? actions;
  final Color backgroundColor;
  final double height;
  final String? iconBackPath;

  const BaseAppBar({
    required this.title,
    super.key,
    this.showBack = true,
    this.actions,
    this.backgroundColor = Colors.white,
    this.height = 52,
    this.iconBackPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: context.statusBarHeight),
      color: backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (showBack)
            AppButton.icon(
              iconPath: iconBackPath ?? Assets.icons.icArrowBack,
              padding: const EdgeInsets.only(left: 16, top: 14, bottom: 14, right: 12),
              backgroundColor: Colors.transparent,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          Expanded(
            child: Text(
              title,
              style: context.textStyle.bodyXlSemiBold.black(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ).wrapPadding(EdgeInsets.only(bottom: 12, left: showBack ? 0 : 16)),
          ),

          if (actions != null) ...actions!,
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
