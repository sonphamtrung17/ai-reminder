import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../../components/components.dart';
import '../../../resource/generated/assets.gen.dart';
import '../../../theme/theme.dart';
import '../list_event_screen.dart';

class EventOfDay extends StatefulWidget {
  const EventOfDay({super.key});

  @override
  State<EventOfDay> createState() => _EventOfDayState();
}

class _EventOfDayState extends State<EventOfDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.cacSuKienTrongNgay,
          style: context.textStyle.headingXsBold.black(context),
        ),
        Space.h12(),
        ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                showDetailEvent(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: context.color.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Mừng sinh nhật Tuấn Anh',
                                  style: context.textStyle.bodyMMedium.black(context),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                    Space.h4(),
                                    AppImage.circle(
                                      size: 24,
                                      url: url,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Space.h8(),
                    SizedBox(
                      height: 26,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 4,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: context.color.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 1, color: context.color.border),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                AppImage.circle(
                                  size: 15,
                                  path: Assets.icons.icSubtract,
                                ),
                                Space.w8(),
                                Text(
                                  'Địa điểm hấp dẫn',
                                  style: context.textStyle.bodySSemiBold.copyWith(
                                    color: context.color.primary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ).wrapPadding(const EdgeInsets.only(right: 4));
                        },
                      ),
                    ),
                  ],
                ),
              ).wrapPadding(const EdgeInsets.only(bottom: 12)),
            );
          },
          itemCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ],
    );
  }

  void showDetailEvent(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: const Color(0x00000000).withValues(alpha: 0.5),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          maxChildSize: 0.85,
          minChildSize: 0.85,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              padding: const EdgeInsets.all(Dimens.d16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: AppButton.icon(
                      padding: EdgeInsets.zero,
                      iconPath: Assets.icons.icClose,
                      backgroundColor: Colors.transparent,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Space.h12(),
                          AppImage.url(
                            url: url,
                            height: Dimens.d170,
                            width: double.infinity,
                            boxFit: BoxFit.fitWidth,
                            borderRadius: 12,
                          ),
                          Row(
                            children: [
                              AppImage.asset(path: Assets.icons.icHomeCalendar),
                              Space.w4(),
                              Expanded(
                                child: Text(
                                  '12:00 - 14:00 T4, 23/08/2025',
                                  style: context.textStyle.bodyMRegular.copyWith(
                                    fontSize: 14,
                                    color: context.color.gray10,
                                  ),
                                ),
                              ),
                            ],
                          ).wrapPadding(const EdgeInsets.only(top: Dimens.d12, bottom: Dimens.d8)),
                          Text(
                            'Ăn trưa cùng đối tác ngân hàng AB Bank',
                            style: context.textStyle.bodyXlSemiBold.black(context),
                          ),
                          Space.h4(),
                          Text(
                            'Mục tiêu:\nThắt chặt mối quan hệ với đối tác\nThảo luận định hướng hợp tác trong giai đoạn mới\nGiao lưu & networking thân mật',
                            style: context.textStyle.bodyMRegular.copyWith(color: context.color.gray8),
                          ),
                          Space.h12(),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: context.color.background,
                            ),
                            padding: const EdgeInsets.all(Dimens.d4),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppImage.circle(
                                  size: 24,
                                  url: url,
                                ),
                                Space.w4(),
                                Text('Ngô Hoàng Anh', style: context.textStyle.bodyMRegular),
                              ],
                            ),
                          ),
                          Space.h20(),
                          Text(
                            S.current.goiYTuAI,
                            style: context.textStyle.bodyLSemiBold,
                          ),
                          Space.h12(),
                          ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: 14,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: IntrinsicWidth(
                                  child: Container(
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: context.color.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(width: 1, color: context.color.border),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AppImage.circle(
                                          size: 15,
                                          path: Assets.icons.icSubtract,
                                        ),
                                        Space.w8(),
                                        Text(
                                          'Địa điểm hấp dẫn',
                                          style: context.textStyle.bodySSemiBold.copyWith(
                                            color: context.color.primary,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ).wrapPadding(const EdgeInsets.only(right: 4)),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return Space.h12();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 72,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: AppButton.textIcon(
                            text: S.current.nhanBan,
                            iconPath: Assets.icons.icCopy,
                            backgroundColor: Colors.transparent,
                            iconColor: context.color.black,
                            isLayoutVertical: true,
                          ),
                        ),
                        Expanded(
                          child: AppButton.textIcon(
                            text: S.current.chinhSua,
                            iconPath: Assets.icons.icEdit,
                            backgroundColor: Colors.transparent,
                            iconColor: context.color.black,
                            isLayoutVertical: true,
                          ),
                        ),
                        Expanded(
                          child: AppButton.textIcon(
                            text: S.current.xoa,
                            iconPath: Assets.icons.icDelete,
                            backgroundColor: Colors.transparent,
                            iconColor: context.color.black,
                            isLayoutVertical: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
