import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/theme.dart';

class AppTypingTextStream extends StatefulWidget {
  final String text; // Chuỗi cần hiển thị
  final Duration speed; // Tốc độ hiển thị
  final TextStyle? style; // Style chữ
  final VoidCallback? onFinished; // Callback khi hoàn thành

  const AppTypingTextStream({
    required this.text,
    super.key,
    this.speed = const Duration(milliseconds: 40),
    this.style,
    this.onFinished,
  });

  @override
  State<AppTypingTextStream> createState() => _AppTypingTextStreamState();
}

class _AppTypingTextStreamState extends State<AppTypingTextStream> {
  late StreamController<String> _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = StreamController<String>();
    _startTyping();
  }

  void _startTyping() {
    Timer.periodic(widget.speed, (timer) {
      if (_currentIndex < widget.text.length) {
        _controller.add(widget.text[_currentIndex]);
        _currentIndex++;
      } else {
        timer.cancel();
        _controller.close();
        widget.onFinished?.call();
      }
    });
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        return Text(
          widget.text.substring(0, _currentIndex),
          style: widget.style ?? context.textStyle.bodyMMedium.gray9(context),
        );
      },
    );
  }
}
