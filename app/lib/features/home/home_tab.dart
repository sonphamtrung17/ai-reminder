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
  final _carouselController = CarouselController();
  final _flexWeights = [278, 57];

  int _currentHeroIndex = 0;

  @override
  void initState() {
    super.initState();

    _carouselController.addListener(() {
      final position = _carouselController.position;
      if (position.hasPixels) {
        final width = context.screenWidth - 32;
        final index = (position.pixels / width).round();
        // setState(() {
        //   _currentHeroIndex = index;
        // });
        print('current index: $_currentHeroIndex');
      }
    });
  }

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
              Text(
                S.current.suKienSapDienRa,
                style: context.textStyle.headingXsBold.black(context),
              ).wrapPadding(const EdgeInsets.only(bottom: 9, left: 16, right: 16, top: 16)),
              SizedBox(
                height: 160,
                child: CarouselView.weighted(
                  controller: _carouselController,
                  flexWeights: _flexWeights,
                  itemSnapping: true,
                  padding: const EdgeInsets.only(right: 8),
                  scrollDirection: Axis.horizontal,
                  onTap: (int value) {
                    print('item tapped $value');
                  },
                  children: List.generate(2, (index) {
                    return AppImage.url(
                      url: url,
                      boxFit: BoxFit.cover,
                    );
                  }),
                ),
              ).wrapPadding(const EdgeInsets.only(left: 16, right: 8)),
              Space.h8(),
              Row(
                children: [
                  Expanded(
                    flex: _flexWeights.first,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AppImage.asset(path: Assets.icons.icHomeClock),
                            Space.w4(),
                            Expanded(
                              child: Text(
                                '3 ${S.current.ngay}',
                                style: context.textStyle.bodySMedium.primary(context),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: context.color.blue.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                              child: Text(
                                'Sinh nhật',
                                style: context.textStyle.bodySMedium.blue(context),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Mừng sinh nhật Tuấn Anh',
                          style: context.textStyle.bodyMMedium.black(context),
                        ).wrapPadding(const EdgeInsetsGeometry.symmetric(vertical: 6)),
                        Row(
                          children: [
                            AppImage.asset(path: Assets.icons.icHomeCalendar),
                            Space.w4(),
                            Expanded(
                              child: Text(
                                'T4, 23/08/2025',
                                style: context.textStyle.bodySRegular.gray8(context),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Space.w16(),
                  Expanded(
                    flex: _flexWeights[1],
                    child: const SizedBox.shrink(),
                  ),
                ],
              ).wrapPadding(const EdgeInsets.only(left: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

const String url =
    'https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=0.752xw:1.00xh;0.175xw,0&resize=1200:*';
