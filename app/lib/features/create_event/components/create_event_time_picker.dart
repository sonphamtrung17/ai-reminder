import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../../theme/theme.dart';
import 'item_container_date_time.dart';

class CreateEventTimePicker extends StatefulWidget {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Function(TimeOfDay) onStartTimeSelected;
  final Function(TimeOfDay) onEndTimeSelected;

  const CreateEventTimePicker({
    required this.startTime,
    required this.endTime,
    required this.onStartTimeSelected,
    required this.onEndTimeSelected,
    super.key,
  });

  @override
  State<CreateEventTimePicker> createState() => _CreateEventTimePickerState();
}

class _CreateEventTimePickerState extends State<CreateEventTimePicker> {
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;

  late TimeOfDay _startTime;
  late TimeOfDay _endTime;

  bool _isSelectStartTime = false;
  bool _isSelectEndTime = false;

  static const int maxMinute = 60;
  static const int maxHour = 24;
  static const int loopCount = 100;
  static const int middleIndex = (maxHour * loopCount) ~/ 2;

  @override
  void initState() {
    super.initState();

    _startTime = widget.startTime;
    _endTime = widget.endTime;
    _hourController = FixedExtentScrollController(initialItem: middleIndex);
    _minuteController = FixedExtentScrollController(initialItem: middleIndex);
  }

  Future<void> _onChangeSelect() async {
    await Future.delayed(const Duration(milliseconds: 50));
    _hourController.jumpToItem(middleIndex + (_isSelectStartTime ? _startTime.hour : _endTime.hour));
    _minuteController.jumpToItem(middleIndex + (_isSelectStartTime ? _startTime.minute : _endTime.minute));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                S.current.gio,
                style: context.textStyle.bodyMSemiBold.black(context),
              ),
            ),
            ItemContainerDateTime(
              isSelect: _isSelectStartTime,
              title: _startTime.convertTimeToHHMM,
              onTap: () {
                setState(() {
                  _isSelectStartTime = !_isSelectStartTime;
                  _isSelectEndTime = false;
                });
                _onChangeSelect();
              },
            ),
            Text(
              '-',
              style: context.textStyle.bodyMMedium.black(context),
            ).wrapPadding(const EdgeInsets.symmetric(horizontal: 4)),
            ItemContainerDateTime(
              isSelect: _isSelectEndTime,
              title: _endTime.convertTimeToHHMM,
              onTap: () {
                setState(() {
                  _isSelectEndTime = !_isSelectEndTime;
                  _isSelectStartTime = false;
                });
                _onChangeSelect();
              },
            ),
          ],
        ),
        Visibility(
          visible: _isSelectStartTime || _isSelectEndTime,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 8),
            height: 112,
            decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Expanded(
                  child: ListWheelScrollView.useDelegate(
                    controller: _hourController,
                    itemExtent: 112 / 3,
                    perspective: 0.003,
                    diameterRatio: 1.5,
                    overAndUnderCenterOpacity: 1,
                    squeeze: 1.1,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      final selectedHour = index % maxHour; // modulo để quay vòng
                      if (_isSelectStartTime) {
                        _startTime = TimeOfDay(hour: selectedHour, minute: _startTime.minute);
                        widget.onStartTimeSelected(_startTime);
                      } else if (_isSelectEndTime) {
                        _endTime = TimeOfDay(hour: selectedHour, minute: _endTime.minute);
                        widget.onEndTimeSelected(_endTime);
                      }
                      setState(() {});
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: maxHour * loopCount,
                      builder: (context, index) {
                        final hour = index % maxHour;
                        final isSelected = (index % maxHour) == (_isSelectStartTime ? _startTime : _endTime).hour;
                        return Center(
                          child: Text(
                            hour.toString().padLeft(2, '0'),
                            style: isSelected
                                ? context.textStyle.bodyLSemiBold.primary(context)
                                : context.textStyle.bodyMMedium.gray5(context),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Text(
                  ':',
                  style: context.textStyle.bodyLMedium.primary(context),
                ),
                Expanded(
                  child: ListWheelScrollView.useDelegate(
                    controller: _minuteController,
                    itemExtent: 112 / 3,
                    perspective: 0.003,
                    diameterRatio: 1.5,
                    overAndUnderCenterOpacity: 1,
                    squeeze: 1.1,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      final selectedMinute = index % maxMinute; // modulo để quay vòng
                      if (_isSelectStartTime) {
                        _startTime = TimeOfDay(hour: _startTime.hour, minute: selectedMinute);
                        widget.onStartTimeSelected(_startTime);
                      } else if (_isSelectEndTime) {
                        _endTime = TimeOfDay(hour: _endTime.hour, minute: selectedMinute);
                        widget.onEndTimeSelected(_endTime);
                      }
                      setState(() {});
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: maxMinute * loopCount,
                      builder: (context, index) {
                        final minute = index % maxMinute;
                        final isSelected = (index % maxMinute) == (_isSelectStartTime ? _startTime : _endTime).minute;
                        return Center(
                          child: Text(
                            minute.toString().padLeft(2, '0'),
                            style: isSelected
                                ? context.textStyle.bodyLSemiBold.primary(context)
                                : context.textStyle.bodyMMedium.gray5(context),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
