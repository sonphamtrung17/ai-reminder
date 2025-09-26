import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:translate/translate.dart';

import '../../core.dart';
import '../home/home_screen.dart';
import 'components/bottom_sheet_new_message.dart';

@RoutePage()
class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final _appNavigator = GetIt.instance.get<AppNavigator>();

  final _messages = <MessageModel>[
    MessageModel(
      0,
      url,
      'Còn 3 hôm nữa là sinh nhật Tuấn Anh, bạn đã chuẩn  bị cho sự kiện này chưa?',
      'H-AI Reminder',
      65,
      '10 phút',
    ),
    MessageModel(
      1,
      url,
      'Nhắc nhở sự kiện gần đến',
      'Admin',
      2,
      '3 ngày',
    ),
    MessageModel(
      2,
      url,
      'Hôm nay khoẻ không em?',
      'Nguyễn Minh Thư',
      1,
      '12/8/2025',
    ),
    MessageModel(
      3,
      url,
      'Ok em ơi',
      'Trần Đình Tuấn',
      0,
      '25/7/2025',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.tinNhan,
        showBack: false,
        backgroundColor: Colors.transparent,
        actions: [
          AppButton.textIcon(
            text: S.current.tao,
            textStyle: context.textStyle.bodyMSemiBold.primary(context),
            iconPath: Assets.icons.icMessageAdd,
            backgroundColor: Colors.transparent,
            spacing: 4,
            onPressed: () {
              _appNavigator.showCustomBottomSheet(
                context: GetIt.instance.get<AppRouter>().navigatorKey.currentContext!,
                child: BottomSheetNewMessage(
                  onSelected: (person) {
                    if (person == null) {
                      _appNavigator.push(const CreateInterestScreen());
                      return;
                    }
                    _appNavigator.push(const ChatScreen());
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        separatorBuilder: (context, index) => Space.h6(),
        itemBuilder: (context, index) {
          final item = _messages[index];

          final child = InkWell(
            onTap: () {
              _appNavigator.push(const ChatScreen());
            },
            child: Row(
              children: [
                AppImage.circle(
                  size: 48,
                  url: item.avatar,
                ),
                Space.w12(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: context.textStyle.bodyLSemiBold.black(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Space.h4(),
                      Text(
                        item.content,
                        style: context.textStyle.bodyMRegular.black(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Space.w12(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item.time,
                      style: context.textStyle.bodySRegular.black(context),
                    ),
                    Space.h5(),
                    Opacity(
                      opacity: item.unreadCount != 0 ? 1 : 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: context.color.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            item.unreadCount.toString(),
                            style: context.textStyle.bodySsMedium.white(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );

          if (item.id == 0 || item.id == 1) {
            return GradientBorderContainer(
              padding: const EdgeInsets.all(12),
              child: child,
            );
          }

          return Container(
            padding: const EdgeInsets.all(12),
            child: child,
          );
        },
        itemCount: _messages.length,
      ),
    );
  }
}

class MessageModel {
  final int id;
  final String avatar;
  final String content;
  final String name;
  final int unreadCount;
  final String time;

  MessageModel(this.id, this.avatar, this.content, this.name, this.unreadCount, this.time);
}
