import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../../../core.dart';

class BottomSheetRepeat extends StatefulWidget {
  final RepeatType? selectedRepeatType;
  final Function(RepeatType) onSelected;

  const BottomSheetRepeat({
    required this.onSelected,
    super.key,
    this.selectedRepeatType,
  });

  @override
  State<BottomSheetRepeat> createState() => _BottomSheetRepeatState();
}

class _BottomSheetRepeatState extends State<BottomSheetRepeat> {
  final _listRepeat = [
    RepeatType(name: 'Không lặp lại', id: 1),
    RepeatType(name: 'Hàng ngày', id: 2),
    RepeatType(name: 'Hàng tuần', id: 3),
    RepeatType(name: 'Hàng tháng', id: 4),
    RepeatType(name: 'Hàng năm', id: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              S.current.lapLai,
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
              final type = _listRepeat[index];
              return InkWell(
                onTap: () {
                  widget.onSelected(type);
                  Navigator.pop(context);
                },
                child: SizedBox(
                  height: 56,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          type.name,
                          style: context.textStyle.bodyLMedium.gray8(context),
                        ),
                      ),
                      if (widget.selectedRepeatType?.id == type.id)
                        AppImage.asset(
                          path: Assets.icons.icEventCheck,
                        ),
                    ],
                  ),
                ),
              );
            },
            itemCount: _listRepeat.length,
          ),
        ),
      ],
    ).wrapPadding(const EdgeInsets.all(16));
  }
}

class RepeatType {
  final String name;
  final int id;

  RepeatType({
    required this.name,
    required this.id,
  });
}
