import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../../../core.dart';

class BottomSheetEventType extends StatefulWidget {
  final EventType? selectedEventType;
  final Function(EventType) onSelected;

  const BottomSheetEventType({
    required this.onSelected,
    super.key,
    this.selectedEventType,
  });

  @override
  State<BottomSheetEventType> createState() => _BottomSheetEventTypeState();
}

class _BottomSheetEventTypeState extends State<BottomSheetEventType> {
  final _listEventType = [
    EventType(name: 'Sinh nhật', id: 1),
    EventType(name: 'Kỷ niệm ngày cưới', id: 2),
    EventType(name: 'Thăm khách hàng', id: 3),
    EventType(name: 'Gặp gỡ đối tác', id: 4),
    EventType(name: 'Ký hợp đồng', id: 5),
    EventType(name: 'Deadline dự án', id: 6),
    EventType(name: 'Sự kiện hội thảo', id: 7),
    EventType(name: 'Team building', id: 8),
    EventType(name: 'Tiệc cưới', id: 9),
    EventType(name: 'Họp lớp', id: 10),
    EventType(name: 'Lịch khám sức khoẻ', id: 11),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              S.current.loaiSuKien,
              style: context.textStyle.headingXsBold.black(context),
            ),
            const Spacer(),
            AppButton.icon(
              padding: EdgeInsets.zero,
              iconPath: Assets.icons.icClose,
              backgroundColor: Colors.transparent,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        Space.h12(),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (_, index) => Divider(
              color: context.color.gray1,
              height: 1,
            ),
            padding: EdgeInsets.zero,
            itemBuilder: (_, index) {
              final eventType = _listEventType[index];
              return InkWell(
                onTap: () {
                  widget.onSelected(eventType);
                  Navigator.pop(context);
                },
                child: SizedBox(
                  height: 56,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          eventType.name,
                          style: context.textStyle.bodyLMedium.gray8(context),
                        ),
                      ),
                      if (widget.selectedEventType?.id == eventType.id)
                        AppImage.asset(
                          path: Assets.icons.icEventCheck,
                        ),
                    ],
                  ),
                ),
              );
            },
            itemCount: _listEventType.length,
          ),
        ),
      ],
    ).wrapPadding(const EdgeInsets.all(16));
  }
}

class EventType {
  final String name;
  final int id;

  EventType({
    required this.name,
    required this.id,
  });
}
