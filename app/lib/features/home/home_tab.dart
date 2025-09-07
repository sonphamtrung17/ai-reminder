import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../blocs/base/base_screen_state.dart';
import '../../blocs/home/home_cubit.dart';
import '../../components/components.dart';
import '../../resource/resource.dart';
import '../../theme/theme.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends BaseScreenState<HomeTab, HomeCubit> {
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
                          Text(
                            S.current.xinChaoHomNayBanTheNao,
                            style: context.textStyle.bodyMSemiBold.black(context),
                          ),
                          Space.h4(),
                          Text(
                            'Còn 3 hôm nữa là sinh nhật Tuấn Anh, bạn đã chuẩn  bị cho sự kiện này chưa? ',
                            style: context.textStyle.bodyMMedium.gray9(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ).wrapPadding(const EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
