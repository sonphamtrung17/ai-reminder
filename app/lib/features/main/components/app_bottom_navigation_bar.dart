import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../blocs/app/app_cubit.dart';
import '../../../blocs/app/app_state.dart';
import '../../../components/space.dart';
import '../../../theme/theme.dart';
import '../main_screen.dart';

class AppBottomNavigationBar extends StatefulWidget {
  final double height;

  const AppBottomNavigationBar({
    required this.height,
    super.key,
  });

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (pre, cur) => pre.indexBottomTab != cur.indexBottomTab,
      builder: (context, state) {
        return Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: const Color(0xFFF4F6FF).withValues(alpha: 0.8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: BottomTab.values.map((e) {
              final index = BottomTab.values.indexOf(e);
              final isSelected = index == state.indexBottomTab;
              return Expanded(
                child: InkWell(
                  onTap: () {
                    context.read<AppCubit>().setIndexBottomTab(index);
                  },
                  child: TweenAnimationBuilder<Color?>(
                    tween: ColorTween(
                      begin: context.color.gray6,
                      end: isSelected ? context.color.primary : context.color.gray6,
                    ),
                    duration: const Duration(milliseconds: 200),
                    builder: (context, color, child) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: isSelected ? const Color(0xff252C6D).withValues(alpha: 0.1) : null,
                              ),
                              child: SvgPicture.asset(
                                e.icon,
                                colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
                              ),
                            ),
                            Space.h4(),
                            Text(
                              e.title,
                              style: isSelected
                                  ? context.textStyle.bodySsSemiBold.copyWith(color: color)
                                  : context.textStyle.bodySsMedium.copyWith(color: color),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
