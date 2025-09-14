import 'package:flutter/material.dart';
import 'package:mypage/screens/my_page_screen.dart';

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
      body: MyPageScreen(
        profileImage: Future.value(null),
        nickname: '김장정',
        onMyRewardsButtonClicked: () {},
        onEditProfileButtonClicked: () {},
        onInquiryButtonClicked: () {},
        onTermsOfServiceButtonClicked: () {},
        onPrivacyPolicyButtonClicked: () {},
        onMarketingPolicyButtonClicked: () {},
        onLogoutButtonClicked: () {},
      ),
    );
  }
}
