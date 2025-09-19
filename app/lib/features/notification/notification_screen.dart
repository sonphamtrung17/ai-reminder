import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';
import '../../blocs/base/base_screen_state.dart';
import '../../blocs/notification/notification_cubit.dart';
import '../../blocs/notification/notification_state.dart';
import '../../components/components.dart';
import '../../resource/generated/assets.gen.dart';
import '../../theme/theme.dart';

@RoutePage()
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends BaseScreenState<NotificationScreen, NotificationCubit> {
  List<NotificationEntity> notifications = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.getNotifications(1);
    });
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: BaseAppBar(
            title: S.current.thongBao,
            backgroundColor: Colors.transparent,
            showBack: true,
          ),
          body: notifications.isEmpty
              ? Column(
                  children: [
                    AppImage.asset(
                      path: Assets.images.imgNotification.path,
                      width: 106,
                      height: 98,
                    ),
                    Text(S.current.chuaCoThongBao, style: context.textStyle.bodyLSemiBold),
                    Text(S.current.cacThongBaoMoiNhatSeXuatHienOday, style: context.textStyle.bodyMRegular),
                  ],
                )
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    var item = notifications[index];
                    return Row(
                      children: [
                        AppImage.url(
                          url: url,
                          width: 92,
                          height: 92,
                          borderRadius: 12,
                        ),
                        Space.w12(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: context.textStyle.bodyLSemiBold.black(context),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Space.h4(),
                              Text(
                                item.message ?? '',
                                style: context.textStyle.bodySRegular.gray8(context),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Space.h8(),
                              Text(
                                item.createdAt,
                                style: context.textStyle.bodySRegular.gray8(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).wrapPadding(const EdgeInsets.only(bottom: 12));
                  },
                  itemCount: notifications.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ).wrapPadding(const EdgeInsets.symmetric(horizontal: Dimens.d16, vertical: Dimens.d12)),
        );
      },
    );
  }

  @override
  Widget buildPageListeners({required Widget child}) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NotificationCubit, NotificationState>(
          listener: (context, state) {
            if (state is GetNotificationSucceedState) {
              notifications = state.notifications;
            }
          },
        ),
      ],
      child: child,
    );
  }
}

const String url =
    'https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=0.752xw:1.00xh;0.175xw,0&resize=1200:*';
