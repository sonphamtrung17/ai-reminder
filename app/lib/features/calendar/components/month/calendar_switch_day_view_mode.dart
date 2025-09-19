import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:translate/translate.dart';

import '../../../../blocs/calendar/calendar_cubit.dart';
import '../../../../blocs/calendar/calendar_state.dart';
import '../../../../components/components.dart';
import '../../../../resource/resource.dart';
import '../../../../theme/theme.dart';

class CalendarSwitchViewMode extends StatefulWidget {
  const CalendarSwitchViewMode({super.key});

  @override
  State<CalendarSwitchViewMode> createState() => _CalendarSwitchViewModeState();
}

class _CalendarSwitchViewModeState extends State<CalendarSwitchViewMode> {
  final _calendarCubit = GetIt.instance.get<CalendarCubit>();

  final duration = const Duration(milliseconds: 200);

  void _onTabSelected(DayViewMode dayViewMode) {
    _calendarCubit.setDayViewMode(dayViewMode);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      bloc: _calendarCubit,
      buildWhen: (previous, current) => previous.dayViewMode != current.dayViewMode,
      builder: (context, state) {
        final selectedIndex = DayViewMode.values.indexOf(state.dayViewMode);

        return Container(
          padding: const EdgeInsets.all(2),
          margin: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            color: context.color.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: context.color.border),
          ),
          child: Stack(
            children: [
              // Background slider với animation
              AnimatedPositioned(
                duration: duration,
                curve: Curves.easeInOut,
                left: selectedIndex * 60,
                child: Container(
                  width: 60,
                  height: 28,
                  decoration: BoxDecoration(
                    color: context.color.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              // Tabs
              Row(
                mainAxisSize: MainAxisSize.min,
                children: DayViewMode.values.map((e) {
                  final isSelected = e == state.dayViewMode;

                  return GestureDetector(
                    onTap: () => _onTabSelected(e),
                    child: AnimatedContainer(
                      duration: duration,
                      width: 60,
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            e.icon.isEmpty
                                ? const SizedBox()
                                : TweenAnimationBuilder<Color?>(
                                    duration: const Duration(milliseconds: 200),
                                    tween: ColorTween(
                                      begin: context.color.gray6,
                                      end: isSelected ? context.color.white : context.color.gray6,
                                    ),
                                    builder: (context, color, child) {
                                      return SvgPicture.asset(
                                        e.icon,
                                        colorFilter: ColorFilter.mode(
                                          color!,
                                          BlendMode.srcIn,
                                        ),
                                      );
                                    },
                                  ),
                            e.icon.isEmpty ? const SizedBox() : Space.w4(),
                            AnimatedDefaultTextStyle(
                              duration: duration,
                              style: context.textStyle.bodyMMedium.copyWith(
                                color: isSelected ? context.color.white : context.color.gray6,
                              ),
                              child: Text(e.title),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

enum DayViewMode {
  all,
  dl,
  al;

  String get title {
    switch (this) {
      case DayViewMode.all:
        return S.current.tatCa;
      case DayViewMode.dl:
        return 'DL';
      case DayViewMode.al:
        return 'AL';
    }
  }

  String get icon {
    switch (this) {
      case DayViewMode.all:
        return '';
      case DayViewMode.dl:
        return Assets.icons.icCalendarDl;
      case DayViewMode.al:
        return Assets.icons.icCalendarAl;
    }
  }
}
