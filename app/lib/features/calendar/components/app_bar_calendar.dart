import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/shared.dart';

import '../../../blocs/calendar/calendar_cubit.dart';
import '../../../blocs/calendar/calendar_state.dart';
import '../../../components/components.dart';
import '../../../navigation/navigation.dart';
import '../../../resource/resource.dart';
import '../../../theme/theme.dart';
import '../calendar_screen.dart';
import 'calendar_view_mode_popup.dart';

class AppBarCalendar extends StatefulWidget implements PreferredSizeWidget {
  const AppBarCalendar({super.key});

  @override
  State<AppBarCalendar> createState() => _AppBarCalendarState();

  @override
  Size get preferredSize => const Size.fromHeight(UiConstants.appBarCalendarHeight);
}

class _AppBarCalendarState extends State<AppBarCalendar> {
  final _moreButtonKey = GlobalKey();
  final _calendarCubit = GetIt.instance.get<CalendarCubit>();
  final _appNavigator = GetIt.instance.get<AppNavigator>() as AppNavigatorImpl;

  void _showCalendarMode() {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => CalendarViewModePopup(
        globalKey: _moreButtonKey,
        mode: _calendarCubit.state.calendarViewMode,
        onClose: () => overlayEntry.remove(),
        onItemSelected: (value) {
          _calendarCubit.setCalendarViewMode(value);
          overlayEntry.remove();
        },
      ),
    );

    overlay.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      bloc: _calendarCubit,
      builder: (context, state) {
        String titleAppbar = '';
        switch (state.calendarViewMode) {
          case CalendarViewMode.year:
            titleAppbar = '${state.focusedDate!.year}';
          case CalendarViewMode.month:
          case CalendarViewMode.week:
            titleAppbar = 'Tháng ${state.focusedDate!.month} năm ${state.focusedDate!.year}';
        }

        return Container(
          padding: EdgeInsets.only(top: context.statusBarHeight),
          color: context.color.bgBrand,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.calendarViewMode != CalendarViewMode.year)
                AppButton.icon(
                  iconPath: Assets.icons.icArrowBack,
                  padding: const EdgeInsets.only(left: 12, top: 10, bottom: 10, right: 12),
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    _appNavigator.pop();
                  },
                ),
              Expanded(
                child:
                    Text(
                      titleAppbar,
                      style: context.textStyle.bodyXlSemiBold.primary(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ).wrapPadding(
                      EdgeInsets.only(
                        top: 8,
                        left: state.calendarViewMode != CalendarViewMode.year ? 0 : 12,
                      ),
                    ),
              ),
              AppButton.icon(
                iconPath: Assets.icons.icCalendarAdd,
                padding: const EdgeInsets.symmetric(vertical: 10),
                backgroundColor: Colors.transparent,
                onPressed: () {
                  // Navigator.of(context).pop();
                },
              ),
              AppButton.icon(
                key: _moreButtonKey,
                iconPath: Assets.icons.icCalendarMore,
                padding: const EdgeInsets.all(12),
                backgroundColor: Colors.transparent,
                onPressed: _showCalendarMode,
              ),
            ],
          ),
        );
      },
    );
  }
}
