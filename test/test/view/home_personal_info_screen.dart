import 'package:flutter/material.dart';
import 'package:login/screens/login_personal_info_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: "Pretendard"),
      home: _TestApp(),
    ),
  );
}

class _TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPersonalInfoScreen(
        profileImage: null,
        nicknameController: TextEditingController(text: "김장정"),
        errorMessage: '중복된 닉네임입니다.',
        onSelectPictureButtonClicked: () {},
        onClearProfileImageButtonClicked: () {},
        onClearNicknameButtonClicked: () {},
        onSubmitButtonClicked: () {},
      ),
    );
  }
}
