import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../../components/components.dart';
import '../../../resource/resource.dart';
import '../../../theme/theme.dart';
import '../home_tab.dart';

class CreatedByMeHome extends StatefulWidget {
  const CreatedByMeHome({super.key});

  @override
  State<CreatedByMeHome> createState() => _CreatedByMeHomeState();
}

class _CreatedByMeHomeState extends State<CreatedByMeHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.daTaoBoiBan,
          style: context.textStyle.headingXsBold.black(context),
        ).wrapPadding(const EdgeInsets.only(top: 24, left: 16, bottom: 8)),
        SizedBox(
          height: 187,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                width: 134,
                height: 187,
                decoration: BoxDecoration(color: context.color.white, borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppImage.url(
                      url: url,
                      width: 123,
                      height: 123,
                      borderRadius: 10,
                    ).wrapPadding(const EdgeInsets.only(top: 4, left: 5.5, right: 5.5)),
                    Text(
                      'Happy Anniversary ❤️ 12/12',
                      style: context.textStyle.bodyMMedium.black(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ).wrapPadding(const EdgeInsets.only(top: 8, bottom: 6, left: 4, right: 4)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppImage.asset(path: Assets.icons.icHomeCalendar),
                        Space.w4(),
                        Text(
                          'T7, 30/08/2025',
                          style: context.textStyle.bodySRegular.gray8(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ).wrapPadding(const EdgeInsets.only(left: 4, right: 4, bottom: 8)),
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
