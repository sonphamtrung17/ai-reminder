import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../blocs/base/base_screen_state.dart';
import '../../blocs/create_event/create_event_cubit.dart';
import '../../core.dart';
import 'components/bottom_sheet/bottom_sheet_event_type.dart';
import 'components/bottom_sheet/bottom_sheet_object.dart';
import 'components/bottom_sheet/bottom_sheet_repeat.dart';
import 'components/create_event_date_picker.dart';
import 'components/create_event_time_picker.dart';
import 'components/item_container_date_time.dart';
import 'components/item_container_event.dart';

@RoutePage()
class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends BaseScreenState<CreateEventScreen, CreateEventCubit> {
  final _titleController = TextEditingController();
  final _typeController = TextEditingController();
  final _repeatController = TextEditingController();
  final _noteController = TextEditingController();

  EventType? _eventType;
  RepeatType? _repeatType;
  Person? _person;

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 1));

  TimeOfDay _startTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 0, minute: 0);

  bool _isSelectStartDate = false;
  bool _isSelectEndDate = false;

  @override
  Widget buildPage(BuildContext context) {
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
              onTap: () {
                navigator.showCustomBottomSheet(
                  context: context,
                  child: BottomSheetEventType(
                    onSelected: (type) {
                      _eventType = type;
                      _typeController.text = type.name;
                    },
                    selectedEventType: _eventType,
                  ),
                );
              },
            ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
                      ItemContainerDateTime(
                        isSelect: _isSelectStartDate,
                        title: _startDate.convertTimeToDDMMYY,
                        onTap: () {
                          setState(() {
                            _isSelectStartDate = !_isSelectStartDate;
                            _isSelectEndDate = false;
                          });
                        },
                      ),
                      Text(
                        '-',
                        style: context.textStyle.bodyMMedium.black(context),
                      ).wrapPadding(const EdgeInsets.symmetric(horizontal: 4)),
                      ItemContainerDateTime(
                        isSelect: _isSelectEndDate,
                        title: _endDate.convertTimeToDDMMYY,
                        onTap: () {
                          setState(() {
                            _isSelectEndDate = !_isSelectEndDate;
                            _isSelectStartDate = false;
                          });
                        },
                      ),
                    ],
                  ).wrapPadding(const EdgeInsets.symmetric(vertical: 8)),
                  CreateEventDatePicker(
                    initialDate: _isSelectStartDate ? _startDate : (_isSelectEndDate ? _endDate : null),
                    onDateSelected: (date) {
                      setState(() {
                        if (_isSelectStartDate) {
                          _startDate = date;
                        } else if (_isSelectEndDate) {
                          _endDate = date;
                        }
                      });
                    },
                  ),
                  CreateEventTimePicker(
                    startTime: _startTime,
                    endTime: _endTime,
                    onStartTimeSelected: (time) {
                      _startTime = time;
                    },
                    onEndTimeSelected: (time) {
                      _endTime = time;
                    },
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                navigator.showCustomBottomSheet(
                  context: context,
                  child: BottomSheetObject(
                    onSelected: (person) {
                      if (person == null) {
                        navigator.push(const CreateInterestScreen());
                        return;
                      }
                      _person = person;
                      setState(() {});
                    },
                    selectedPerson: _person,
                  ),
                );
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppImage.asset(path: Assets.icons.icEventObject),
                        Space.w8(),
                        Expanded(
                          child: Text(
                            S.current.doiTuong,
                            style: context.textStyle.bodyLMedium.black(context),
                          ),
                        ),
                        AppImage.asset(path: Assets.icons.icEventArrowRight),
                      ],
                    ),
                    _person != null
                        ? Container(
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: context.color.background,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppImage.circle(
                                  size: 24,
                                  url: _person?.avatar,
                                  boxFit: BoxFit.cover,
                                ),
                                Space.w4(),
                                Text(
                                  _person?.name ?? '',
                                  style: context.textStyle.bodyMRegular.black(context),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            ItemContainerEvent(
              controller: _repeatController,
              iconPath: Assets.icons.icEventSync,
              hint: S.current.khongLapLai,
              isSingleLine: true,
              onTap: () {
                navigator.showCustomBottomSheet(
                  context: context,
                  child: BottomSheetRepeat(
                    onSelected: (type) {
                      _repeatType = type;
                      _repeatController.text = type.name;
                    },
                    selectedRepeatType: _repeatType,
                  ),
                );
              },
            ),
            ItemContainerEvent(
              controller: _noteController,
              iconPath: Assets.icons.icEventNote,
              hint: S.current.nhapSoThich,
            ),
          ],
        ),
      ).wrapPadding(const EdgeInsets.symmetric(horizontal: 16)),
      bottomNavigationBar: AppButton.textIcon(
        text: S.current.xacNhan,
        iconPath: Assets.icons.icCheck,
        spacing: 8,
        textStyle: context.textStyle.bodyLSemiBold.white(context),
      ).wrapPadding(const EdgeInsets.all(16)),
    );
  }
}
