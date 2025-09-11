import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  bool get _isFilled =>
      _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onChanged);
    _passwordController.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.05),

                      // Logo
                      Container(
                        width: screenWidth * 0.25,
                        height: screenWidth * 0.25,
                        child: Center(
                          child: Image.asset(
                            "assets/images/splash_icon.png",
                            width: screenWidth * 0.20,
                            height: screenWidth * 0.20,
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      // Title
                      Text(
                        "Xin chào !",
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: screenHeight * 0.01),

                      // Subtitle
                      Text(
                        "Hãy ghi lại, ghi nhớ và trân trọng những khoảnh khắc ý nghĩa.",
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      // Form container
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(screenWidth * 0.05),
                          color: Colors.blue.withAlpha((0.1 * 255).round()),
                        ),
                        child: Column(
                          children: [
                            // Email
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      screenWidth * 0.03),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.04,
                                  vertical: screenHeight * 0.018,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),

                            // Password
                            TextField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                hintText: "Mật khẩu",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      screenWidth * 0.03),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.04,
                                  vertical: screenHeight * 0.018,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () => setState(() =>
                                  _obscurePassword = !_obscurePassword),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.025),

                            // Login button
                            SizedBox(
                              width: double.infinity,
                              height: screenHeight * 0.06,
                              child: ElevatedButton(
                                onPressed: _isFilled ? () {} : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isFilled
                                      ? Colors.blue.shade800
                                      : Colors.grey.shade300,
                                  foregroundColor: _isFilled
                                      ? Colors.white
                                      : Colors.black54,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.03),
                                  ),
                                ),
                                child: Text(
                                  "Đăng nhập",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.025),

                            // Or
                            Text(
                              "Hoặc",
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),

                            // Social login
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _socialButton(
                                  screenWidth,
                                  screenHeight,
                                  "Google",
                                  Colors.white,
                                  "assets/icons/ic_google.svg",
                                ),
                                SizedBox(width: screenWidth * 0.05),
                                _socialButton(
                                  screenWidth,
                                  screenHeight,
                                  "Apple",
                                  Colors.white,
                                  "assets/icons/ic_apple.svg",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // Footer
                      Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                        child: Text(
                          "Bằng việc sử dụng H-AI Reminder, bạn đồng ý với Điều khoản dịch vụ của chúng tôi.",
                          style: TextStyle(
                            fontSize: screenWidth * 0.03,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _socialButton(
      double screenWidth,
      double screenHeight,
      String label,
      Color background,
      String asset,
      ) {
    return Container(
      width: screenWidth * 0.35,
      height: screenHeight * 0.055,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        color: background,
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(asset, width: screenWidth * 0.05),
          SizedBox(width: screenWidth * 0.02),
          Text(
            label,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              color: background == Colors.black ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
