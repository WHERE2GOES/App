import 'package:design/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.onLoginWithKakaoButtonClicked,
    required this.onLoginWithGoogleButtonClicked,
  });

  final VoidCallback onLoginWithKakaoButtonClicked;
  final VoidCallback onLoginWithGoogleButtonClicked;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.pastelYellow,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 52.5, vertical: 61.2),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SvgPicture.asset(
                    "assets/images/img_logo.svg",
                    package: "login",
                    width: 145.78,
                  ),
                ),
              ),
              Column(
                spacing: 7.3,
                children: [
                  _buildLoginButton(
                    icon: Image.asset(
                      "assets/images/img_kakao_logo.png",
                      package: "login",
                      width: 24,
                    ),
                    message: "카카오톡으로 1초 시작하기",
                    backgroundColor: const Color(0xFFFEE500),
                    onClicked: widget.onLoginWithKakaoButtonClicked,
                  ),
                  _buildLoginButton(
                    icon: Image.asset(
                      "assets/images/img_google_logo.png",
                      package: "login",
                      width: 20,
                    ),
                    message: "Google로 1초 시작하기",
                    backgroundColor: Colors.white,
                    onClicked: widget.onLoginWithGoogleButtonClicked,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton({
    required Widget icon,
    required String message,
    required Color backgroundColor,
    required VoidCallback onClicked,
  }) {
    return GestureDetector(
      onTap: onClicked,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(5.59),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: ThemeColors.grey800, width: 0.5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            SizedBox(width: 30, height: 30, child: Center(child: icon)),
            Expanded(
              child: Center(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 13.86,
                    color: ThemeColors.grey800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
