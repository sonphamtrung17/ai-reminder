import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../../../components/components.dart';
import '../../../theme/theme.dart';

class CalendarYearView extends StatefulWidget {
  final int year;
  final Function(int month) onMonthTap;

  const CalendarYearView({required this.year, required this.onMonthTap, super.key});

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
          onTap: () {
            widget.onMonthTap.call(index + 1);
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
        : GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 105 / 120,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            crossAxisSpacing: 14,
            mainAxisSpacing: 35,
            children: _monthWidgets!,
          );
  }
}

class MonthInYearWidget extends StatefulWidget {
  final int year;
  final int month;
  final VoidCallback? onTap;

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
    widget.onTap?.call();
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
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: constraints.maxWidth / (constraints.maxHeight * 7 / 6),
          ),
          itemCount: 42, // 6 weeks * 7 days
          itemBuilder: (context, index) {
            final dayNumber = index - firstWeekday + 2;

            if (dayNumber < 1 || dayNumber > daysInMonth) {
              return const SizedBox.shrink();
            }

            // Check if it's today
            final isToday = year == now.year && month == now.month && dayNumber == now.day;

            return Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: isToday ? context.color.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  '$dayNumber',
                  style: context.textStyle.bodySssSemiBold.copyWith(
                    color: isToday ? context.color.white : context.color.black,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
