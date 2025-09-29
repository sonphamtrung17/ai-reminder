import 'package:flutter/material.dart';

class GooeyIndicatorPainter extends CustomPainter {
  final double page;
  final int count;

  GooeyIndicatorPainter({required this.page, required this.count});

  @override
  void paint(Canvas canvas, Size size) {
    final inactive = Paint()..color = Colors.white30;
    final active = Paint()..color = Colors.white;

    const pillW = 40.0;
    const pillH = 10.0;
    const activeW = 24.0;
    const spacing = 44.0;
    final totalW = (count - 1) * spacing;
    final startX = (size.width - totalW) / 2;

    for (int i = 0; i < count; i++) {
      final x = startX + i * spacing;
      final rect = Rect.fromCenter(center: Offset(x, size.height / 2), width: pillW, height: pillH);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(pillH)), inactive);
    }

    final current = page.floor();
    final prog = page - current;
    final curX = startX + current * spacing;
    final nextX = startX + ((current + 1) % count) * spacing;

    final curW = activeW * (1 - prog);
    final nextW = activeW * prog;

    if (curW > 0) {
      final rect = Rect.fromLTWH(curX - pillW / 2, (size.height - pillH) / 2, curW, pillH);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(pillH)), active);
    }
    if (nextW > 0) {
      final rect = Rect.fromLTWH(nextX - pillW / 2, (size.height - pillH) / 2, nextW, pillH);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(pillH)), active);
    }
  }

  @override
  bool shouldRepaint(covariant GooeyIndicatorPainter old) => old.page != page || old.count != count;
}
