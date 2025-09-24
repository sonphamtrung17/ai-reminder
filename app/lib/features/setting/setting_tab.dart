import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../navigation/router/app_router.gr.dart';
import '../../resource/generated/assets.gen.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_themes.dart';

class SettingTab extends StatelessWidget {
  const SettingTab({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.08),

            // ==== User Info ====
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(Assets.images.imgAvatar.path),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nguyễn Bá Thanh",
                          style: context.textStyle.bodyLSemiBold.black(context),
                        ), const SizedBox(height: 4),
                        Space.h5(),
                        Text(
                          "bathanhnguyen@gmail.com",
                          style: context.textStyle.bodySRegular.gray5(context),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Image.asset(
                      Assets.icons.icBorderColor.path,
                      width: 20,
                      height: 20,
                    ),
                    onPressed: () => context.router.push(SettingProfileScreen()),
                  ),
                ],
              ),
            ),

            // ==== Menu list ====
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  SettingMenuItem(
                    leading: Image.asset(Assets.icons.icGTranslate.path, width: 22, height: 22,),
                    title: 'Ngôn ngữ',
                    onPressed: () {
                      
                    },
                  ),
                  const Divider(height: 1),
                  SettingMenuItem(
                    leading: Image.asset(
                      Assets.icons.icLanguage.path,
                      width: 22,
                      height: 22,
                    ),
                    title: "(GMT+7) Giờ Đông Dương",
                    onPressed: () {},
                  ),
                  const Divider(height: 1),
                  SettingMenuItem(
                    leading: Image.asset(Assets.icons.icArticlePerson.path, width: 22, height: 22,),
                    title: 'Đối tượng quan tâm',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            /// Log out button
            Space.h8(),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0x1FEE0A24),
                    foregroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Log out",
                    style: context.textStyle.bodyLMedium.red(context),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class SettingMenuItem extends StatelessWidget {
  final Widget leading;
  final String title;
  final VoidCallback onPressed;

  const SettingMenuItem({
    super.key,
    required this.leading,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(
        title,
        style: context.textStyle.bodyMMedium.black(context),
      ),
      trailing: IconButton(
        icon: Image.asset(
          Assets.icons.icKeyboardArrowRight.path,
          width: 24,
          height: 24,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
