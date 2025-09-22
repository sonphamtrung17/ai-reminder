import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../../../components/components.dart';
import '../../../../resource/resource.dart';
import '../../../../theme/theme.dart';
import 'calendar_week_view.dart';

class CalendarWeekEventView extends StatefulWidget {
  final List<CalendarEvent> events;

  const CalendarWeekEventView({required this.events, super.key});

  @override
  State<CalendarWeekEventView> createState() => _CalendarWeekEventViewState();
}

class _CalendarWeekEventViewState extends State<CalendarWeekEventView> {
  final double hourHeight = 50;
  final double timeColumnWidth = 40;
  double eventsAreaWidth = 720.0;
  final int hours = 24;
  final double eventWidth = 44;

  void _calculateEventsAreaWidth() {
    final areaWidth = eventWidth * widget.events.length;
    if (areaWidth > eventsAreaWidth) {
      eventsAreaWidth = areaWidth;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateEventsAreaWidth();
    });
  }

  @override
  void didUpdateWidget(covariant CalendarWeekEventView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.events.length != oldWidget.events.length) {
      _calculateEventsAreaWidth();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double totalHeight = hours * hourHeight;

    return Expanded(
      child: widget.events.isEmpty
          ? _buildEmptyEvents()
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cột giờ: cố định bên trái
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 10),
                    width: timeColumnWidth,
                    child: Column(
                      children: List.generate(hours, (i) {
                        return SizedBox(
                          height: hourHeight,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              '${i.toString().padLeft(2, '0')}:00',
                              style: context.textStyle.bodySRegular.gray8(context),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: eventsAreaWidth,
                        height: totalHeight,
                        child: Stack(
                          children: [
                            ..._buildEventWidgets(
                              hourHeight,
                              eventsAreaWidth,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildEmptyEvents() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppImage.asset(
            path: Assets.images.imgCalendarEmptyEvent.path,
            width: 108,
          ),
          Text(
            S.current.chuaCoSuKienNao,
            style: context.textStyle.bodyMMedium.gray8(context),
          ).wrapPadding(const EdgeInsets.symmetric(vertical: 12)),
          AppButton.textIcon(
            text: S.current.tao,
            textStyle: context.textStyle.bodyMSemiBold.primary(context),
            iconPath: Assets.icons.icAdd,
            backgroundColor: Colors.white,
            spacing: Dimens.d8,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  /// Tạo widget Positioned cho mỗi event.
  List<Widget> _buildEventWidgets(double hourHeight, double maxWidth) {
    final List<Widget> widgets = [];

    // Sort event theo start time để đảm bảo thứ tự
    widget.events.sort((a, b) => a.start.compareTo(b.start));

    const double gutter = 6;
    const double leftPadding = 0;

    int colIndex = 0;

    for (final ev in widget.events) {
      final startMinutes = ev.start.hour * 60 + ev.start.minute;
      final endMinutes = ev.end.hour * 60 + ev.end.minute;
      final top = (startMinutes / 60.0 * hourHeight) + (hourHeight / 2);
      final height = (endMinutes - startMinutes) / 60.0 * hourHeight;

      final left = leftPadding + colIndex * (eventWidth + gutter);

      widgets.add(
        Positioned(
          top: top,
          left: left,
          width: eventWidth,
          height: height,
          child: Container(
            decoration: BoxDecoration(
              color: ev.color.withValues(alpha: 0.52),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      );

      widgets.add(
        Positioned(
          top: top,
          left: 0,
          width: eventsAreaWidth,
          height: 1,
          child: DottedDashedLine(
            height: 1,
            width: 100,
            axis: Axis.horizontal,
            dashColor: context.color.gray3,
          ),
        ),
      );

      widgets.add(
        Positioned(
          top: top - 20,
          left: left,
          width: eventsAreaWidth,
          height: height,
          child: Text(
            ev.title,
            style: context.textStyle.bodySSemiBold.black(context),
          ),
        ),
      );

      colIndex++;
    }

    return widgets;
  }
}
