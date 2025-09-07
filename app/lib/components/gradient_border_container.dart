import 'package:flutter/material.dart';

class GradientBorderContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const GradientBorderContainer({
    required this.child,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFE249),
            Color(0xFFF35950),
            Color(0xFF7C5BFF),
            Color(0xFF1CE4FF),
            Color(0xFF5FFF5C),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        margin: const EdgeInsets.all(1.5), // độ dày viền
        padding: padding ?? const EdgeInsets.all(10), // padding bên trong
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4B69FC).withValues(alpha: 0.12),
              blurRadius: 0,
              offset: const Offset(0, 0),
              spreadRadius: 2,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
