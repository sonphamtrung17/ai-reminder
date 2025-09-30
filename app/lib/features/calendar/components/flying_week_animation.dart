import 'package:flutter/material.dart';

class FlyingWeekAnimation {
  static Future<void> animateWeekTransition({
    required BuildContext context,
    required Widget sourceWidget,
    required Widget destinationWidget,
    required Rect sourceRect,
    required Rect destinationRect,
    required VoidCallback onComplete,
    Duration duration = const Duration(milliseconds: 800),
  }) async {
    final overlay = Overlay.of(context);
    late OverlayEntry flyingWidget;

    flyingWidget = OverlayEntry(
      builder: (context) => _FlyingWidget(
        sourceWidget: sourceWidget,
        destinationWidget: destinationWidget,
        sourceRect: sourceRect,
        destinationRect: destinationRect,
        duration: duration,
        onComplete: () {
          flyingWidget.remove();
          onComplete();
        },
      ),
    );

    overlay.insert(flyingWidget);
  }
}

class _FlyingWidget extends StatefulWidget {
  final Widget sourceWidget;
  final Widget destinationWidget;
  final Rect sourceRect;
  final Rect destinationRect;
  final Duration duration;
  final VoidCallback onComplete;

  const _FlyingWidget({
    required this.sourceWidget,
    required this.destinationWidget,
    required this.sourceRect,
    required this.destinationRect,
    required this.duration,
    required this.onComplete,
  });

  @override
  State<_FlyingWidget> createState() => _FlyingWidgetState();
}

class _FlyingWidgetState extends State<_FlyingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<Rect?> _rectAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _rectAnimation = RectTween(
      begin: widget.sourceRect,
      end: widget.destinationRect,
    ).animate(_animation);

    _controller.forward().then((_) {
      widget.onComplete();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final rect = _rectAnimation.value ?? widget.sourceRect;
        
        return Positioned(
          left: rect.left,
          top: rect.top,
          width: rect.width,
          height: rect.height,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2 * _animation.value),
                  blurRadius: 8 * _animation.value,
                  offset: Offset(0, 4 * _animation.value),
                ),
              ],
            ),
            child: _animation.value < 0.5
                ? widget.sourceWidget
                : widget.destinationWidget,
          ),
        );
      },
    );
  }
}