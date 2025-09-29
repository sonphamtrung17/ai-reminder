import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../blocs/base/base_screen_state.dart';
import '../../blocs/login/login_cubit.dart';
import '../../core.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseScreenState<LoginScreen, LoginCubit> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool _obscurePassword = true;

  bool get _isFilled => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  child: AppImage.asset(path: Assets.images.gridLogin.path),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          SizedBox(height: screenHeight * 0.10),

                          // Logo
                          Center(
                            child: AppImage.asset(
                              path: Assets.images.splashIcon.path,
                              width: screenWidth * 0.2,
                              height: screenWidth * 0.2,
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.03),

                          // Title
                          Text(
                            'Xin chào !',
                            style: context.textStyle.bodyMSemiBold.black(
                              context,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: screenHeight * 0.01),

                          // Subtitle
                          Text(
                            'Hãy ghi lại, ghi nhớ và trân trọng những khoảnh\n khắc ý nghĩa.',
                            style: context.textStyle.bodyMSemiBold.black(
                              context,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: screenHeight * 0.04),

                          // Form container
                          Container(
                            padding: EdgeInsets.all(screenWidth * 0.04),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(screenWidth * 0.05),
                              color: AppColors.background3,
                            ),
                            child: Column(
                              children: [
                                // Email field
                                InlineLabelTextField(
                                  controller: _emailController,
                                  focusNode: _emailFocus,
                                  label: 'Email',
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(height: screenHeight * 0.02),

                                // Password field
                                InlineLabelTextField(
                                  controller: _passwordController,
                                  focusNode: _passwordFocus,
                                  label: 'Mật khẩu',
                                  obscureText: _obscurePassword,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                    ),
                                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                                  ),
                                ),

                                SizedBox(height: screenHeight * 0.025),

                                // Login button
                                InkWell(
                                  onTap: _isFilled
                                      ? () {

                                          navigator.replace(const MainScreen());
                                        }
                                      : null,
                                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                                  child: Container(
                                    width: screenWidth * 0.702,
                                    height: screenHeight * 0.053,
                                    decoration: BoxDecoration(
                                      color: _isFilled ? AppColors.buttonColor : AppColors.gray1,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Đăng nhập',
                                      style: _isFilled
                                          ? context.textStyle.bodyMSemiBold.white(context, fontSize: 16)
                                          : context.textStyle.bodyMSemiBold.gray(
                                              context,
                                              color: AppColors.gray3,
                                              fontSize: 16,
                                            ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: screenHeight * 0.025),

                                // Or
                                Text(
                                  'Hoặc',
                                  style: context.textStyle.bodyMSemiBold.gray(
                                    context,
                                    color: AppColors.gray5,
                                    fontSize: 14,
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
                                      'Google',
                                      Colors.white,
                                      Assets.icons.icGoogle,
                                    ),
                                    SizedBox(width: screenWidth * 0.05),
                                    _socialButton(
                                      screenWidth,
                                      screenHeight,
                                      'Apple',
                                      Colors.white,
                                      Assets.icons.icApple,
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
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: context.textStyle.bodyMSemiBold.gray(
                                  context,
                                  color: AppColors.gray8,
                                  fontSize: 14,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'Bằng việc sử dụng H-AI Reminder, bạn đồng ý với\n',
                                  ),
                                  TextSpan(
                                    text: 'Điều khoản dịch vụ của chúng tôi.',
                                    style: context.textStyle.bodyMSemiBold.primary(context, fontSize: 14),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // context.pushRoute(WebViewRoute(url: "https://example.com/terms"));
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
      height: screenHeight * 0.05,
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

class InlineLabelTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;

  const InlineLabelTextField({
    required this.controller,
    required this.focusNode,
    required this.label,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    super.key,
  });

  @override
  State<InlineLabelTextField> createState() => _InlineLabelTextFieldState();
}

class _InlineLabelTextFieldState extends State<InlineLabelTextField> {
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() => _isFocused = widget.focusNode.hasFocus);
    });
    widget.controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    final hasText = widget.controller.text.isNotEmpty;

    final showLabel = !_isFocused;
    final labelIsSmall = !_isFocused && hasText;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isFocused ? AppColors.buttonColor : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Stack(
        children: [
          // TextField
          TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(
                screenWidth * 0.04,
                labelIsSmall ? screenHeight * 0.02 : screenHeight * 0.02,
                widget.suffixIcon != null ? screenWidth * 0.12 : screenWidth * 0.04,
                screenHeight * 0.018,
              ),
              suffixIcon: widget.suffixIcon,
            ),
          ),

          if (showLabel)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 160),
              curve: Curves.easeOut,
              left: screenWidth * 0.04,
              top: labelIsSmall ? screenHeight * 0.006 : screenHeight * 0.018,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 160),
                style: TextStyle(
                  fontSize: labelIsSmall ? screenWidth * 0.032 : screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
                child: Text(widget.label),
              ),
            ),
        ],
      ),
    );
  }
}
