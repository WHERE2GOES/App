import 'package:flutter/material.dart';
import 'package:login/screens/login_terms_agreement_screen.dart';

void main() {
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
      body: LoginTermsAgreementScreen(
        onTermsClicked: (termsType) {},
        onAgreeClicked: () {},
      ),
    );
  }
}
