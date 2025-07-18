import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:login/screens/login_screen.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key, required this.onLoginSucceeded});

  final VoidCallback onLoginSucceeded;

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  @override
  Widget build(BuildContext context) {
    return LoginScreen(
      onLoginWithKakaoButtonClicked: _loginWithKakao,
      onLoginWithGoogleButtonClicked: _loginWithGoogle,
    );
  }

  void _loginWithKakao() async {
    try {
      final token = switch (await isKakaoTalkInstalled()) {
        true => await UserApi.instance.loginWithKakaoTalk(),
        false => await UserApi.instance.loginWithKakaoAccount(),
      };

      // TODO: 서버에서 로그인 처리
      widget.onLoginSucceeded();
    } catch (error) {
      // TODO: 에러 처리
    }
  }

  void _loginWithGoogle() {
    // TODO: google login
  }
}
