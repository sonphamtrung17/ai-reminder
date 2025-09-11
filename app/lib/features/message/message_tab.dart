import 'package:flutter/material.dart';

class MessageTab extends StatefulWidget {
  const MessageTab({super.key});

  @override
  State<MessageTab> createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  final months = List.generate(12, (i) => "Tháng ${i + 1}");
  final _overlayKey = GlobalKey();

  OverlayEntry? _overlayEntry;

  void _showMonthDetail(BuildContext context, int index, Rect itemRect) {
    final month = months[index];
    final screenSize = MediaQuery.of(context).size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return AnimatedMonthOverlay(
          month: month,
          startRect: itemRect,
          endRect: Rect.fromLTWH(0, 0, screenSize.width, screenSize.height),
          onClose: () {
            _overlayEntry?.remove();
            _overlayEntry = null;
          },
        );
      },
    );

    Overlay.of(context, debugRequiredFor: widget)?.insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calendar")),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: months.length,
        itemBuilder: (context, index) {
          final month = months[index];
          return Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  // Lấy vị trí & kích thước của widget trong màn hình
                  final renderBox =
                  context.findRenderObject() as RenderBox?;
                  final offset = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
                  final size = renderBox?.size ?? Size.zero;
                  final rect = Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);

                  _showMonthDetail(context, index, rect);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.red.shade100,
                  ),
                  child: Text(month,
                      style: const TextStyle(fontSize: 16, color: Colors.black)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// Widget overlay animating from a rect to fullscreen
class AnimatedMonthOverlay extends StatefulWidget {
  final String month;
  final Rect startRect;
  final Rect endRect;
  final VoidCallback onClose;

  const AnimatedMonthOverlay({
    super.key,
    required this.month,
    required this.startRect,
    required this.endRect,
    required this.onClose,
  });

  @override
  State<AnimatedMonthOverlay> createState() => _AnimatedMonthOverlayState();
}

class _AnimatedMonthOverlayState extends State<AnimatedMonthOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Rect?> _rectAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 400));

    _rectAnimation = RectTween(
      begin: widget.startRect,
      end: widget.endRect,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  void _close() async {
    await _controller.reverse();
    widget.onClose();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _rectAnimation,
        builder: (context, child) {
          final rect = _rectAnimation.value!;
          return Stack(
            children: [
              Positioned(
                left: rect.left,
                top: rect.top,
                width: rect.width,
                height: rect.height,
                child: Material(
                  borderRadius: BorderRadius.circular(
                      (1 - _controller.value) * 12), // bo góc khi nhỏ
                  color: Colors.red.shade300,
                  child: InkWell(
                    onTap: _close,
                    child: Center(
                      child: Text(
                        widget.month,
                        style: TextStyle(
                          fontSize: 20 + 12 * _controller.value,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
