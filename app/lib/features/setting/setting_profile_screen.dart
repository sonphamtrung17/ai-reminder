import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../resource/generated/assets.gen.dart';

@RoutePage()
class SettingProfileScreen extends StatefulWidget {
  const SettingProfileScreen({super.key});

  @override
  State<SettingProfileScreen> createState() => _SettingProfileScreenState();
}

class _SettingProfileScreenState extends State<SettingProfileScreen> {
  final TextEditingController nameController = TextEditingController(text: "Nguyễn Bá Thanh");
  final TextEditingController dobController = TextEditingController(text: "14/12/1989");
  final TextEditingController emailController = TextEditingController(text: "bathanhnguyen@gmail.com");

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime initialDate = DateFormat("dd/MM/yyyy").parse(dobController.text);
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        dobController.text = DateFormat("dd/MM/yyyy").format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.router.pop(),
        ),
        title: const Text(
          "Hồ sơ của tôi",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.05),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  /// Avatar
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(Assets.images.imgAvatar.path),
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(Assets.images.imgAvatar.path),
                          ),
                          Positioned(
                            bottom: -10,
                            right: -10,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: Image.asset(
                                Assets.icons.icCamera.path,
                                width: 28,
                                height: 28,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                  const SizedBox(height: 24),
                  /// Name
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Họ và tên",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// Date of birth
                  TextField(
                    controller: dobController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Ngày sinh",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_month_outlined),
                        onPressed: _pickDate,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// Email
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      /// Button save
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                debugPrint("Tên: ${nameController.text}");
                debugPrint("Ngày sinh: ${dobController.text}");
                debugPrint("Email: ${emailController.text}");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2A78),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Lưu lại",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
