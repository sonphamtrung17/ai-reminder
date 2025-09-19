import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/components.dart';
import '../../../theme/theme.dart';
import '../calendar_screen.dart';

class CalendarViewModePopup extends StatefulWidget {
  final GlobalKey globalKey;
  final VoidCallback onClose;
  final CalendarViewMode mode;
  final Function(CalendarViewMode) onItemSelected;

  const CalendarViewModePopup({
    required this.globalKey,
    required this.onClose,
    required this.mode,
    required this.onItemSelected,
    super.key,
  });

  @override
  State<CalendarViewModePopup> createState() => _CalendarViewModePopupState();
}

class _CalendarViewModePopupState extends State<CalendarViewModePopup> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation =
        Tween<double>(
          begin: 0.8,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutBack,
          ),
        );

    _opacityAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOut,
          ),
        );

    // Start animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _closeWithAnimation() {
    _animationController.reverse().then((_) {
      widget.onClose();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Lấy position của button
    final RenderBox? buttonBox = widget.globalKey.currentContext?.findRenderObject() as RenderBox?;
    Offset buttonPosition;
    if (buttonBox == null) {
      buttonPosition = Offset.zero;
    } else {
      buttonPosition = buttonBox.localToGlobal(Offset.zero);
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Stack(
        children: [
          // Background
          GestureDetector(
            onTap: _closeWithAnimation,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
            ),
          ),

          // Animated menu
          Positioned(
            right: 14,
            top: buttonPosition.dy + 7 + 24 + 12,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  child: Container(
                    width: 166,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.44),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          offset: const Offset(0, 32),
                          blurRadius: 48,
                          spreadRadius: -8,
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          offset: const Offset(0, 0),
                          blurRadius: 14,
                          spreadRadius: -4,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _buildAnimatedItems(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAnimatedItems() {
    return CalendarViewMode.values.map((entry) {
      final color = widget.mode == entry ? context.color.white : context.color.black;
      final textStyle = widget.mode == entry
          ? context.textStyle.bodyMMedium.white(context)
          : context.textStyle.bodyMMedium.gray8(context);
      final bgColor = widget.mode == entry ? context.color.primary : Colors.transparent;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => widget.onItemSelected(entry),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    entry.icon,
                    colorFilter: ColorFilter.mode(
                      color,
                      BlendMode.srcIn,
                    ),
                  ),
                  Space.w8(),
                  Text(entry.title, style: textStyle),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}
