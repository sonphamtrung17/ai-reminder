import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../../components/components.dart';
import '../../../resource/resource.dart';
import '../../../theme/theme.dart';
import '../home_screen.dart';

class HolidayComingHome extends StatefulWidget {
  const HolidayComingHome({super.key});

  @override
  State<HolidayComingHome> createState() => _HolidayComingHomeState();
}

class _HolidayComingHomeState extends State<HolidayComingHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.ngayLeSapDen,
          style: context.textStyle.headingXsBold.black(context),
        ).wrapPadding(const EdgeInsets.only(top: 24, left: 16, bottom: 8)),
        SizedBox(
          height: 92 + 4 + 42,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 92,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppImage.url(
                      url: url,
                      width: 92,
                      height: 92,
                      borderRadius: 16,
                    ),
                    Text(
                      'Quốc Khánh',
                      style: context.textStyle.bodyMMedium.black(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ).wrapPadding(const EdgeInsets.symmetric(vertical: 4)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppImage.asset(path: Assets.icons.icHomeClock),
                        Space.w4(),
                        Text(
                          '2 ${S.current.ngay}',
                          style: context.textStyle.bodySMedium.primary(context),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => Space.w8(),
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
