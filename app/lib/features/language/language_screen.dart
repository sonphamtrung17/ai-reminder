import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:translate/translate.dart';

import '../../resource/generated/assets.gen.dart';
import '../../theme/theme.dart';

@RoutePage()
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedCode = 'vi';

  static final _items = <LanguageItem>[
    LanguageItem(code: 'vi', flag: Assets.icons.icFlagVN.path),
    LanguageItem(code: 'en', flag: Assets.icons.icFlagUS.path),
  ];

  // Map code -> label from ARB (không hard-code trong model)
  String _labelFor(BuildContext context, String code) {
    final s = S.of(context);
    switch (code) {
      case 'vi':
        return s.languageVietnamese; // app_vi.arb: "Tiếng Việt"
      case 'en':
        return s.languageEnglish; // app_en.arb: "English"
      default:
        return code;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.router.pop(),
        ),
        title: Text(
          s.selectLanguageTitle, // "Ngôn ngữ" / "Language"
          style: context.textStyle.bodyMSemiBold.black(
            context,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: DecoratedBox(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 20,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < _items.length; i++) ...[
                  _LanguageTile(
                    item: _items[i],
                    title: _labelFor(context, _items[i].code),
                    selected: _items[i].code == _selectedCode,
                    onTap: () => setState(() {
                      _selectedCode = _items[i].code;
                    }),
                  ),
                  if (i < _items.length - 1)
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.gray3,
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.item,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final LanguageItem item;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          children: [
            Image.asset(item.flag, width: 24),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: context.textStyle.bodyMSemiBold.black(
                  context,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (selected) const Icon(Icons.check, size: 22, color: AppColors.black),
          ],
        ),
      ),
    );
  }
}

class LanguageItem {
  final String code; // 'vi', 'en'
  final String flag; // asset path
  const LanguageItem({required this.code, required this.flag});
}
