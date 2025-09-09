import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../../components/components.dart';
import '../../../theme/theme.dart';
import '../home_tab.dart';

class NotificationHome extends StatefulWidget {
  const NotificationHome({super.key});

  @override
  State<NotificationHome> createState() => _NotificationHomeState();
}

class _NotificationHomeState extends State<NotificationHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.thongBao,
          style: context.textStyle.headingXsBold.black(context),
        ).wrapPadding(const EdgeInsets.only(top: 24, left: 16, bottom: 12)),
        ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
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
                        'Nâng cấp hệ thống bảo mật',
                        style: context.textStyle.bodyLSemiBold.black(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Space.h4(),
                      Text(
                        'Hệ thống sẽ được bảo trì để nâng cấp lớp bảo mật dữ liệu.',
                        style: context.textStyle.bodySRegular.gray8(context),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Space.h8(),
                      Text(
                        '23/08/2025',
                        style: context.textStyle.bodySRegular.gray8(context),
                      ),
                    ],
                  ),
                ),
              ],
            ).wrapPadding(const EdgeInsets.only(left: 16, right: 16, bottom: 12));
          },
          itemCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ],
    );
  }
}
