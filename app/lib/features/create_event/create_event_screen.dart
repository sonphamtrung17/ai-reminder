import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../components/components.dart';
import '../../resource/resource.dart';
import '../../theme/theme.dart';
import 'components/custom_date_picker.dart';

@RoutePage()
class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _titleController = TextEditingController();
  final _typeController = TextEditingController();
  final _objectController = TextEditingController();
  final _repeatController = TextEditingController();
  final _noteController = TextEditingController();

  final DateTime _startDate = DateTime.now();
  final DateTime _endDate = DateTime.now().add(const Duration(hours: 3));

  bool _isSelectStartDate = false;
  bool _isSelectEndDate = false;
  bool _isSelectStartTime = false;
  bool _isSelectEndTime = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.suKienMoi,
        iconBackPath: Assets.icons.icEventClose,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemContainerEvent(
              controller: _titleController,
              iconPath: Assets.icons.icEventTitle,
              hint: S.current.tieuDeSuKien,
            ),
            ItemContainerEvent(
              controller: _typeController,
              iconPath: Assets.icons.icEventType,
              hint: S.current.loaiSuKien,
              isSingleLine: true,
              onTap: () {},
            ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      AppImage.asset(path: Assets.icons.icEventTime),
                      Space.w8(),
                      Text(
                        S.current.thoiGian,
                        style: context.textStyle.bodyLMedium.black(context),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          S.current.ngayEvent,
                          style: context.textStyle.bodyMSemiBold.black(context),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 17),
                        decoration: BoxDecoration(
                          border: _isSelectStartDate ? Border.all(width: 1, color: context.color.primary) : null,
                          color: context.color.gray1,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _startDate.convertTimeToDDMMYY,
                          style: context.textStyle.bodyMMedium.copyWith(
                            color: _isSelectStartDate ? context.color.primary : context.color.black,
                          ),
                        ),
                      ),
                      Text(
                        '-',
                        style: context.textStyle.bodyMMedium.black(context),
                      ).wrapPadding(const EdgeInsets.symmetric(horizontal: 4)),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 17),
                        decoration: BoxDecoration(
                          border: _isSelectEndDate ? Border.all(width: 1, color: context.color.primary) : null,
                          color: context.color.gray1,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _endDate.convertTimeToDDMMYY,
                          style: context.textStyle.bodyMMedium.copyWith(
                            color: _isSelectEndDate ? context.color.primary : context.color.black,
                          ),
                        ),
                      ),
                    ],
                  ).wrapPadding(const EdgeInsets.symmetric(vertical: 8)),
                  CustomDatePicker(initialDate: DateTime.now()),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          S.current.gio,
                          style: context.textStyle.bodyMSemiBold.black(context),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 17),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: context.color.primary),
                          color: context.color.gray1,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '23/08/2025',
                          style: context.textStyle.bodyMMedium.primary(context),
                        ),
                      ),
                      Text(
                        '-',
                        style: context.textStyle.bodyMMedium.black(context),
                      ).wrapPadding(const EdgeInsets.symmetric(horizontal: 4)),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 17),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: context.color.primary),
                          color: context.color.gray1,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '23/08/2025',
                          style: context.textStyle.bodyMMedium.primary(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ItemContainerEvent(
              controller: _objectController,
              iconPath: Assets.icons.icEventObject,
              hint: S.current.doiTuong,
              isSingleLine: true,
              onTap: () {},
            ),
            ItemContainerEvent(
              controller: _repeatController,
              iconPath: Assets.icons.icEventSync,
              hint: S.current.khongLapLai,
              isSingleLine: true,
              onTap: () {},
            ),
            ItemContainerEvent(
              controller: _noteController,
              iconPath: Assets.icons.icEventNote,
              hint: S.current.nhapSoThich,
            ),
          ],
        ),
      ).wrapPadding(const EdgeInsets.symmetric(horizontal: 16)),
    );
  }
}

class ItemContainerEvent extends StatelessWidget {
  final TextEditingController controller;
  final String iconPath;
  final String hint;
  final bool isSingleLine;
  final Function? onTap;

  const ItemContainerEvent({
    required this.controller,
    required this.iconPath,
    required this.hint,
    this.isSingleLine = false,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppImage.asset(path: iconPath),
          Space.w8(),
          Expanded(
            child: TextField(
              controller: controller,
              enabled: onTap == null,
              style: context.textStyle.bodyLMedium.black(context),
              decoration: InputDecoration(
                isDense: true,
                hintText: hint,
                hintStyle: context.textStyle.bodyLMedium.gray5(context),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              minLines: isSingleLine ? 1 : 4,
              maxLines: isSingleLine ? 1 : 6,
            ),
          ),
          onTap != null
              ? GestureDetector(
                  onTap: () => onTap?.call(),
                  child: AppImage.asset(path: Assets.icons.icEventArrowRight),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
