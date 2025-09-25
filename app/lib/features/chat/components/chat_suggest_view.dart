import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../../../core.dart';

class ChatSuggestView extends StatefulWidget {
  const ChatSuggestView({super.key});

  @override
  State<ChatSuggestView> createState() => _ChatSuggestViewState();
}

class _ChatSuggestViewState extends State<ChatSuggestView> {
  final List<String> _suggest = ['Địa điểm hấp dẫn', 'Món quà ý nghĩa', 'Nơi thu hút sự chú ý'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: AppImage.asset(
            path: Assets.icons.icChatArrowDown,
          ).wrapPadding(const EdgeInsets.symmetric(vertical: 12)),
        ),
        Wrap(
          children: _suggest
              .map(
                (e) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  margin: const EdgeInsets.only(right: 8, bottom: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppImage.asset(path: Assets.icons.icChatStartAi),
                      Space.w4(),
                      Text(
                        e,
                        style: context.textStyle.bodyMMedium.primary(context),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ).wrapPadding(const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
      ],
    );
  }
}
