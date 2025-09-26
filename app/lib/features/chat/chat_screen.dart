import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../core.dart';
import '../home/home_screen.dart';
import 'components/chat_suggest_view.dart';
import 'components/item_chat_me.dart';
import 'components/item_chat_partner.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  final List<ChatMessage> _messages = [
    ChatMessage(
      avatar: url,
      text: 'Địa điểm tổ chức sinh nhật ở quận Bình Tân',
      isUser: true,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
    ),
    ChatMessage(
      avatar: url,
      text: 'Hehe',
      isUser: false,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
    ),
    ChatMessage(
      avatar: url,
      text: 'Còn 3 hôm nữa là sinh nhật Tuấn Anh, bạn đã chuẩn bị cho sự kiện này chưa?',
      isUser: false,
      timestamp: DateTime.now(),
    ),
  ];

  bool _isShowSuggest = false;

  @override
  Widget build(BuildContext context) {
    _messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const BaseAppBar(
        title: 'H-AI Reminder',
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final nextMessage = index == _messages.length - 1 ? null : _messages[index + 1];

                final label = _getDateLabelAtIndex(index: index);

                return Column(
                  children: [
                    if (label != null)
                      Center(
                        child: Text(
                          label,
                          style: context.textStyle.bodySRegular.gray8(context),
                        ),
                      ).wrapPadding(const EdgeInsets.only(bottom: 12)),
                    message.isUser
                        ? ItemChatMe(
                            message: message,
                            nextMessage: nextMessage,
                          )
                        : ItemChatPartner(
                            message: message,
                            nextMessage: nextMessage,
                          ),
                  ],
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: context.color.white,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _isShowSuggest ? const ChatSuggestView() : const SizedBox.shrink(),
                Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: context.padding.bottom > 0 ? context.padding.bottom : 16,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xffEEF1FF),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xffE5E8FF),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isShowSuggest = !_isShowSuggest;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: context.color.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: AppImage.asset(
                              path: _isShowSuggest ? Assets.icons.icChatClose : Assets.icons.icChatMenu,
                            ),
                          ),
                        ),
                        Space.w8(),
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              hintText: S.current.nhapTinNhan,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                            ),
                          ),
                        ),
                        Space.w8(),
                        Container(
                          width: 32,
                          height: 32,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(color: context.color.primary, shape: BoxShape.circle),
                          child: AppImage.asset(path: Assets.icons.icChatSend),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? _getDateLabelAtIndex({required int index}) {
    final message = _messages[index];
    final DateTime? previousDate = index > 0 ? _messages[index - 1].timestamp : null;

    // Nếu không có previous (đầu danh sách hiển thị) hoặc khác ngày -> show label
    if (previousDate == null || !DateTimeUtils.isSameDate(message.timestamp, previousDate)) {
      if (DateTimeUtils.isToday(message.timestamp)) {
        return S.current.homNay;
      }
      return message.timestamp.convertTimeToDDMMYY;
    }

    return null;
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String avatar;
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.avatar,
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}
