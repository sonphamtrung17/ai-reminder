import 'package:flutter/material.dart';

import '../../../components/components.dart';
import '../../../resource/resource.dart';
import '../../../theme/theme.dart';

class ItemContainerEvent extends StatelessWidget {
  final TextEditingController controller;
  final String iconPath;
  final String hint;
  final bool isSingleLine;
  final Function? onTap;

  const ItemContainerEvent({
    required this.controller,
    required this.iconPath,
    required this.hint,
    this.isSingleLine = false,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage.asset(path: iconPath),
            Space.w8(),
            Expanded(
              child: TextField(
                controller: controller,
                enabled: onTap == null,
                style: context.textStyle.bodyLMedium.black(context),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: hint,
                  hintStyle: context.textStyle.bodyLMedium.gray5(context),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                minLines: isSingleLine ? 1 : 4,
                maxLines: isSingleLine ? 1 : 6,
              ),
            ),
            onTap != null ? AppImage.asset(path: Assets.icons.icEventArrowRight) : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
