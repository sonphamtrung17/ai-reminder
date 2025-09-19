import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../../../components/components.dart';
import '../../../theme/theme.dart';

class CalendarYearView extends StatefulWidget {
  final int year;
  final Function(int month, Rect rect) onMonthTap;

  const CalendarYearView({
    required this.year,
    required this.onMonthTap,
    super.key,
  });

  @override
  State<CalendarYearView> createState() => _CalendarYearViewState();
}

class _CalendarYearViewState extends State<CalendarYearView> with AutomaticKeepAliveClientMixin {
  List<MonthInYearWidget>? _monthWidgets;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    // Build months lazily
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _buildMonthWidgets();
      }
    });
  }

  void _buildMonthWidgets() {
    setState(() {
      _monthWidgets = List.generate(12, (index) {
        return MonthInYearWidget(
          year: widget.year,
          month: index + 1,
          onTap: (rect) {
            widget.onMonthTap.call(index + 1, rect);
          },
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return _monthWidgets == null
        ? Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]!),
              ),
            ),
          )
        : Column(
            children: [
              for (int row = 0; row < 4; row++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: row < 3 ? 20 : 0),
                    child: Row(
                      children: [
                        for (int col = 0; col < 3; col++) ...[
                          if (col > 0) Space.w14(),
                          Expanded(
                            child: _monthWidgets![row * 3 + col],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
            ],
          ).wrapPadding(const EdgeInsets.symmetric(horizontal: 16));
  }
}

class MonthInYearWidget extends StatefulWidget {
  final int year;
  final int month;
  final Function(Rect rect)? onTap;

  const MonthInYearWidget({required this.year, required this.month, this.onTap, super.key});

  @override
  State<MonthInYearWidget> createState() => _MonthWidgetState();
}

class _MonthWidgetState extends State<MonthInYearWidget> with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation =
        Tween<double>(
          begin: 1.0,
          end: 0.9,
        ).animate(
          CurvedAnimation(
            parent: _scaleController,
            curve: Curves.easeInOut,
          ),
        );
  }

  int get _daysInMonth => DateTime(widget.year, widget.month + 1, 0).day;

  int get _firstWeekday {
    final firstDay = DateTime(widget.year, widget.month, 1);
    return firstDay.weekday == 7 ? 7 : firstDay.weekday;
  }

  void _handleTapDown(TapDownDetails details) {
    _scaleController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _scaleController.reverse();

    if (widget.onTap != null) {
      // Get the widget's position and size in global coordinates
      final renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final offset = renderBox.localToGlobal(Offset.zero);
        final size = renderBox.size;
        final rect = Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);
        widget.onTap!(rect);
      }
    }
  }

  void _handleTapCancel() {
    _scaleController.reverse();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isCurrentMonth = widget.year == now.year && widget.month == now.month;

    return GestureDetector(
      onTapDown: widget.onTap != null ? _handleTapDown : null,
      onTapUp: widget.onTap != null ? _handleTapUp : null,
      onTapCancel: widget.onTap != null ? _handleTapCancel : null,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Month name
                Text(
                  CalendarConstants.monthNames[widget.month - 1],
                  style: context.textStyle.bodyLSemiBold.copyWith(
                    color: isCurrentMonth ? context.color.primary : context.color.black,
                  ),
                ),
                Space.h6(),

                // Weekday headers
                Row(
                  children: CalendarConstants.weekDays
                      .map(
                        (day) => Expanded(
                          child: Center(
                            child: Text(
                              day,
                              style: context.textStyle.bodySssMedium.gray7(context),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Space.h2(),

                // Calendar grid
                Expanded(
                  child: CalendarDayInYearGrid(
                    year: widget.year,
                    month: widget.month,
                    daysInMonth: _daysInMonth,
                    firstWeekday: _firstWeekday,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CalendarDayInYearGrid extends StatelessWidget {
  final int year;
  final int month;
  final int daysInMonth;
  final int firstWeekday;

  const CalendarDayInYearGrid({
    required this.year,
    required this.month,
    required this.daysInMonth,
    required this.firstWeekday,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return LayoutBuilder(
      builder: (context, constraints) {
        final List<Widget> weeks = [];
        int dayCounter = 2 - firstWeekday;

        // Build 6 weeks
        for (int week = 0; week < 6; week++) {
          final List<Widget> days = [];

          // Build 7 days for each week
          for (int weekday = 0; weekday < 7; weekday++) {
            if (dayCounter < 1 || dayCounter > daysInMonth) {
              days.add(
                const Expanded(child: SizedBox.shrink()),
              );
            } else {
              final isToday = year == now.year && month == now.month && dayCounter == now.day;
              days.add(
                Expanded(
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: isToday ? context.color.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        '$dayCounter',
                        style: context.textStyle.bodySssSemiBold.copyWith(
                          color: isToday ? context.color.white : context.color.black,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            dayCounter++;
          }

          weeks.add(
            Row(
              children: days,
            ),
          );
        }

        return Column(
          children: weeks,
        );
      },
    );
  }
}
