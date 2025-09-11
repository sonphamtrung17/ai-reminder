import 'package:flutter/material.dart';

class CrossFadeText extends StatelessWidget {
  final String base;
  final String next;
  final double progress;
  final TextStyle? style;
  final TextAlign? align;

  const CrossFadeText({
    super.key,
    required this.base,
    required this.next,
    required this.progress,
    this.style,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: 1 - progress,
          child: Text(base, style: style, textAlign: align),
        ),
        Opacity(
          opacity: progress,
          child: Text(next, style: style, textAlign: align),
        ),
      ],
    );
  }
}
