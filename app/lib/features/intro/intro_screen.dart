import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/shared.dart';
import 'package:translate/translate.dart';

import '../../core.dart';
import 'widgets/cross_fade_text.dart';
import 'widgets/gooey_indicator.dart';

@RoutePage()
class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final _appPreferences = GetIt.instance.get<AppPreferences>();

  final PageController _controller = PageController(initialPage: 0);
  int _settledPage = 0;

  final List<String> backgrounds = [
    Assets.images.imgIntro1.path,
    Assets.images.imgIntro2.path,
    Assets.images.imgIntro3.path,
  ];

  final List<String> centerImages = [
    Assets.images.imgIntro1Center.path,
    Assets.images.imgIntro2Center.path,
    Assets.images.imgIntro3Center.path,
  ];

  final List<String> titles = [
    'H-AI Reminder',
    S.current.nhacBanNgayDacBiet,
    'Chatbot AI',
  ];

  final List<String> subtitles = [
    S.current.nhacNhoNgaySinh,
    S.current.giupBanKhongQuen,
    S.current.nhacNhoSuKien,
  ];

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

  _PageState _pageState(int count) {
    final rawPage = _controller.hasClients && _controller.page != null ? _controller.page! : _settledPage.toDouble();

    final base = rawPage.floor().clamp(0, count - 1);
    final prog = (rawPage - base).clamp(0.0, 1.0);

    final next = (base + 1).clampIndex(count);
    return _PageState(rawPage, base, next, prog);
  }

  Widget _backgroundItem(String asset) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(asset), fit: BoxFit.cover),
      ),
      child: DecoratedBox(
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
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);
    final count = backgrounds.length;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background fade
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final state = _pageState(count);
              return Stack(
                fit: StackFit.expand,
                children: [
                  Opacity(
                    opacity: 1 - state.progress,
                    child: _backgroundItem(backgrounds[state.base]),
                  ),
                  Opacity(
                    opacity: state.progress,
                    child: _backgroundItem(backgrounds[state.next]),
                  ),
                ],
              );
            },
          ),

          // PageView
          PageView.builder(
            controller: _controller,
            itemCount: count,
            onPageChanged: (i) => setState(() => _settledPage = i),
            itemBuilder: (_, _) => const SizedBox.expand(),
          ),

          // Center image
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final state = _pageState(count);

              final imageSize = screen.width * 0.7;
              final top = (screen.height - imageSize) / 3;
              final baseOffset = -state.progress * screen.width;
              final nextOffset = (1 - state.progress) * screen.width;

              return Positioned(
                top: top.clamp(0, double.infinity),
                left: (screen.width - imageSize) / 2,
                child: IgnorePointer(
                  child: SizedBox(
                    width: imageSize,
                    height: imageSize,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Transform.translate(
                          offset: Offset(baseOffset, 0),
                          child: Image.asset(
                            centerImages[state.base],
                            fit: BoxFit.contain,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(nextOffset, 0),
                          child: Image.asset(
                            centerImages[state.next],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Bottom content
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: _buildBottomContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomContent() {
    final count = backgrounds.length;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final state = _pageState(count);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPaint(
              painter: GooeyIndicatorPainter(
                page: state.rawPage % count,
                count: count,
              ),
              child: const SizedBox(width: 128, height: 20),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 38,
              child: CrossFadeText(
                base: titles[state.base],
                next: titles[state.next],
                progress: state.progress,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                align: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: CrossFadeText(
                  base: subtitles[state.base],
                  next: subtitles[state.next],
                  progress: state.progress,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  align: TextAlign.center,
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
                  onPressed: () {
                    _appPreferences.saveIsFirsLaunchApp(false);
                    context.router.replace(const LoginScreen());
                  },
                  child: Text(
                    S.current.dangNhap,
                    style: context.textStyle.bodyLSemiBold.black(context),
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

extension on int {
  int clampIndex(int max) => (this < 0) ? 0 : (this >= max ? max - 1 : this);
}

class _PageState {
  final double rawPage;
  final int base;
  final int next;
  final double progress;

  _PageState(this.rawPage, this.base, this.next, this.progress);
}
