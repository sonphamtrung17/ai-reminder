import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../../../core.dart';
import '../chat_screen.dart';

class ItemChatMe extends StatefulWidget {
  final ChatMessage message;
  final ChatMessage? nextMessage;

  const ItemChatMe({
    required this.message,
    this.nextMessage,
    super.key,
  });

  @override
  State<ItemChatMe> createState() => _ItemChatMeState();
}

class _ItemChatMeState extends State<ItemChatMe> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              constraints: BoxConstraints(maxWidth: (context.screenWidth - 32) * 260 / 343),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(8),
                ),
                color: context.color.primary,
              ),
              child: Text(
                widget.message.text,
                style: context.textStyle.bodyLMedium.white(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
