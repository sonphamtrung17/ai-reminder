import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../../components/components.dart';
import '../../../resource/resource.dart';
import '../../../theme/theme.dart';
import '../list_event_screen.dart';

class UpcomingEvent extends StatefulWidget {
  const UpcomingEvent({super.key});

  @override
  State<UpcomingEvent> createState() => _UpcomingEventState();
}

class _UpcomingEventState extends State<UpcomingEvent> {
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
        _currentHeroIndex = index;
        Log.d('Current hero index: $_currentHeroIndex');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 160,
          child: CarouselView.weighted(
            controller: _carouselController,
            flexWeights: _flexWeights,
            itemSnapping: true,
            padding: const EdgeInsets.only(right: 8),
            scrollDirection: Axis.horizontal,
            onTap: (int value) {
              Log.d('item tapped $value');
            },
            children: List.generate(6, (index) {
              return AppImage.url(
                url: url,
                boxFit: BoxFit.cover,
              );
            }),
          ),
        ),
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
        ),
      ],
    );
  }
}
