import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController(initialPage: 0);

  final GlobalKey _bottomKey = GlobalKey();
  double _bottomHeight = 0;

  final List<String> backgrounds = [
    'assets/images/img_intro_1.png',
    'assets/images/img_intro_2.png',
    'assets/images/img_intro_3.png',
  ];

  final List<String> centerImages = [
    'assets/images/img_intro_1_center.png',
    'assets/images/img_intro_2_center.png',
    'assets/images/img_intro_3_center.png',
  ];

  final List<String> titles = [
    "H-AI Reminder",
    "Nhắc bạn ngày đặc biệt",
    "Chatbot AI",
  ];

  final List<String> subtitles = [
    "Nhắc nhở ngày sinh, ngày kỉ niệm, sự kiện, thông tin khách hàng, và nhiều hơn thế.",
    "Giúp bạn không quên những ngày kỉ niệm với gia đình, bạn bè, những sự kiện quan trọng của BU.",
    "Nhắc nhở sự kiện, gợi ý công việc cần chuẩn bị.",
  ];

  int _indexFromRawPage(double rawPage, int count) {
    double page = rawPage % count;
    if (page < 0) page += count;
    return page.floor();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var bg in backgrounds) {
        precacheImage(AssetImage(bg), context);
      }
      for (var img in centerImages) {
        precacheImage(AssetImage(img), context);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemBuilder: (context, index) {
              final realIndex = index % backgrounds.length;
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(backgrounds[realIndex]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.2),
                        Colors.black.withValues(alpha: 0.7),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              );
            },
          ),

          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final double rawPage =
              _controller.hasClients && _controller.page != null
                  ? _controller.page!
                  : 0.0;

              final int baseIndex =
              _indexFromRawPage(rawPage, backgrounds.length);
              final int nextIndex = (baseIndex + 1) % backgrounds.length;
              final double progress = rawPage - rawPage.floor();

              final double imageSize = screenWidth * 0.7;
              final double top = (screenHeight - _bottomHeight - imageSize) / 2;

              return Positioned(
                top: top > 0 ? top : 0,
                left: (screenWidth - imageSize) / 2,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    _controller.position.moveTo(
                      _controller.position.pixels - details.delta.dx,
                    );
                  },
                  child: SizedBox(
                    width: imageSize,
                    height: imageSize,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (progress == 0)
                          Image.asset(
                            centerImages[baseIndex],
                            width: imageSize,
                            height: imageSize,
                            fit: BoxFit.contain,
                          )
                        else ...[
                          Opacity(
                            opacity: 1 - progress,
                            child: Image.asset(
                              centerImages[baseIndex],
                              width: imageSize,
                              height: imageSize,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Opacity(
                            opacity: progress,
                            child: Image.asset(
                              centerImages[nextIndex],
                              width: imageSize,
                              height: imageSize,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: MeasureSize(
                onChange: (size) {
                  if (size.height != _bottomHeight) {
                    setState(() => _bottomHeight = size.height);
                  }
                },
                child: _buildBottomContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomContent() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double rawPage =
        _controller.hasClients && _controller.page != null
            ? _controller.page!
            : 0.0;
        double normalizedPage = rawPage % backgrounds.length;
        if (normalizedPage < 0) {
          normalizedPage += backgrounds.length;
        }

        final int baseIndex = _indexFromRawPage(rawPage, backgrounds.length);
        final int nextIndex = (baseIndex + 1) % backgrounds.length;
        final double progress = rawPage - rawPage.floor();

        return Column(
          key: _bottomKey,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPaint(
              painter: GooeyIndicatorPainter(
                page: normalizedPage,
                count: backgrounds.length,
              ),
              child: const SizedBox(width: 128, height: 20),
            ),

            const SizedBox(height: 24),

            SizedBox(
              height: 32,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: 1 - progress,
                    child: Text(
                      titles[baseIndex],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Opacity(
                    opacity: progress,
                    child: Text(
                      titles[nextIndex],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: 1 - progress,
                      child: Text(
                        subtitles[baseIndex],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Opacity(
                      opacity: progress,
                      child: Text(
                        subtitles[nextIndex],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Đăng nhập",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class MeasureSize extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onChange;

  const MeasureSize({super.key, required this.onChange, required this.child});

  @override
  State<MeasureSize> createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = context.size;
      if (size != null) {
        widget.onChange(size);
      }
    });
    return widget.child;
  }
}

class GooeyIndicatorPainter extends CustomPainter {
  final double page;
  final int count;

  GooeyIndicatorPainter({required this.page, required this.count});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint inactivePaint = Paint()..color = Colors.white30;
    final Paint activePaint = Paint()..color = Colors.white;

    const double pillWidth = 40.0;
    const double pillHeight = 10.0;
    const double activeWidth = 24.0;
    const double spacing = 44.0;

    final double totalWidth = (count - 1) * spacing;
    final double startX = (size.width - totalWidth) / 2;

    for (int i = 0; i < count; i++) {
      double x = startX + i * spacing;
      Rect rect = Rect.fromCenter(
        center: Offset(x, size.height / 2),
        width: pillWidth,
        height: pillHeight,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(pillHeight)),
        inactivePaint,
      );
    }

    int currentPage = page.floor();
    double progress = page - currentPage;

    double currentX = startX + currentPage * spacing;
    double nextX = startX + ((currentPage + 1) % count) * spacing;

    double currentLeft = currentX - pillWidth / 2;
    double nextLeft = nextX - pillWidth / 2;

    double currentWidth = activeWidth * (1 - progress);
    if (currentWidth > 0) {
      Rect rect = Rect.fromLTWH(
        currentLeft,
        (size.height - pillHeight) / 2,
        currentWidth,
        pillHeight,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(pillHeight)),
        activePaint,
      );
    }

    double nextWidth = activeWidth * progress;
    if (nextWidth > 0) {
      Rect rect = Rect.fromLTWH(
        nextLeft,
        (size.height - pillHeight) / 2,
        nextWidth,
        pillHeight,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(pillHeight)),
        activePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant GooeyIndicatorPainter oldDelegate) {
    return oldDelegate.page != page || oldDelegate.count != count;
  }
}
