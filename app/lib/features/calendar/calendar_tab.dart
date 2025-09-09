import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../resource/resource.dart';

class CalendarTab extends StatelessWidget {
  const CalendarTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Lịch',
        showBack: false,
        actions: [
          AppButton.textIcon(text: 'Tạo', iconPath: Assets.icons.icHomeNoti,backgroundColor: Colors.white,
          spacing: 0,onPressed: (){},),
        ],
      ),
    );
  }
}
