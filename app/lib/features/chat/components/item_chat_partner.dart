import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../../../core.dart';
import '../chat_screen.dart';

class ItemChatPartner extends StatefulWidget {
  final ChatMessage message;
  final ChatMessage? nextMessage;

  const ItemChatPartner({
    required this.message,
    this.nextMessage,
    super.key,
  });

  @override
  State<ItemChatPartner> createState() => _ItemChatPartnerState();
}

class _ItemChatPartnerState extends State<ItemChatPartner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppImage.circle(
            url: widget.message.avatar,
            size: 32,
          ),
          Space.w8(),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              constraints: BoxConstraints(maxWidth: (context.screenWidth - 32) * 260 / 343),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(20),
                ),
                color: Color(0xffE5EAFF),
              ),
              child: Text(
                widget.message.text,
                style: context.textStyle.bodyLMedium.black(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
