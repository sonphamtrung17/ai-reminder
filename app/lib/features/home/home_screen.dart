import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../blocs/base/base_screen_state.dart';
import '../../blocs/home/home_cubit.dart';
import '../../components/components.dart';
import '../../resource/resource.dart';
import '../../theme/theme.dart';
import 'components/created_by_me_home.dart';
import 'components/holiday_coming_home.dart';
import 'components/notification_home.dart';
import 'components/upcoming_event_home.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreenState<HomeScreen, HomeCubit> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: context.statusBarHeight),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: AppImage.asset(path: Assets.icons.icHomeApp),
                  ),
                  const Spacer(),
                  AppButton.icon(
                    iconPath: Assets.icons.icHomeNoti,
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    onPressed: () {},
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppImage.asset(
                    path: Assets.images.imgHomeBot.path,
                    width: 28,
                    height: 28,
                  ),
                  Space.w8(),
                  Expanded(
                    child: GradientBorderContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTypingTextStream(
                            text: S.current.xinChaoHomNayBanTheNao,
                            style: context.textStyle.bodyMSemiBold.black(context),
                          ),
                          Space.h4(),
                          AppTypingTextStream(
                            text: 'Còn 3 hôm nữa là sinh nhật Tuấn Anh, bạn đã chuẩn  bị cho sự kiện này chưa? ',
                            style: context.textStyle.bodyMMedium.gray9(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ).wrapPadding(const EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
              const UpcomingEventHome(),
              const HolidayComingHome(),
              const CreatedByMeHome(),
              const NotificationHome(),
              Space.h100(),
            ],
          ),
        ),
      ),
    );
  }
}

const String url =
    'https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=0.752xw:1.00xh;0.175xw,0&resize=1200:*';
