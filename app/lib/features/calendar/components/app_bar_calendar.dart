import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../blocs/calendar/calendar_cubit.dart';
import '../../../components/components.dart';
import '../../../resource/resource.dart';
import '../../../theme/theme.dart';
import 'calendar_view_mode_popup.dart';

class AppBarCalendar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color backgroundColor;

  const AppBarCalendar({
    required this.title,
    super.key,
    this.actions,
    this.backgroundColor = Colors.white,
  });

  @override
  State<AppBarCalendar> createState() => _AppBarCalendarState();

  @override
  Size get preferredSize => const Size.fromHeight(UiConstants.appBarCalendarHeight);
}

class _AppBarCalendarState extends State<AppBarCalendar> {
  final _moreButtonKey = GlobalKey();

  void _showCalendarMode() {
    final calendarCubit = context.read<CalendarCubit>();
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => CalendarViewModePopup(
        globalKey: _moreButtonKey,
        mode: calendarCubit.state.calendarViewMode,
        onClose: () => overlayEntry.remove(),
        onItemSelected: (value) {
          calendarCubit.setCalendarViewMode(value);
          overlayEntry.remove();
        },
      ),
    );

    overlay.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: context.statusBarHeight),
      color: context.color.bgBrand,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              widget.title,
              style: context.textStyle.bodyXlSemiBold.primary(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ).wrapPadding(const EdgeInsets.only(bottom: 10, top: 10, left: 12)),
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
  }
}
