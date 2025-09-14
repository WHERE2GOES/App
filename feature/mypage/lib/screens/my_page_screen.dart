import 'dart:typed_data';

import 'package:design/theme/theme_colors.dart';
import 'package:design/widget/future_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({
    super.key,
    required this.profileImage,
    required this.nickname,
    required this.onMyRewardsButtonClicked,
    required this.onEditProfileButtonClicked,
    required this.onInquiryButtonClicked,
    required this.onTermsOfServiceButtonClicked,
    required this.onPrivacyPolicyButtonClicked,
    required this.onMarketingPolicyButtonClicked,
    required this.onLogoutButtonClicked,
  });

  final Future<Uint8List?>? profileImage;
  final String? nickname;
  final VoidCallback onMyRewardsButtonClicked;
  final VoidCallback onEditProfileButtonClicked;
  final VoidCallback onInquiryButtonClicked;
  final VoidCallback onTermsOfServiceButtonClicked;
  final VoidCallback onPrivacyPolicyButtonClicked;
  final VoidCallback onMarketingPolicyButtonClicked;
  final VoidCallback onLogoutButtonClicked;

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    final menuItems = [
      (title: "1:1 문의", onClicked: widget.onInquiryButtonClicked),
      (title: "이용약관", onClicked: widget.onTermsOfServiceButtonClicked),
      (title: "개인정보 처리방침", onClicked: widget.onPrivacyPolicyButtonClicked),
      (
        title: "마케팅 정보 수집 및 활용 동의",
        onClicked: widget.onMarketingPolicyButtonClicked,
      ),
      (title: "로그아웃", onClicked: widget.onLogoutButtonClicked),
    ];

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: ThemeColors.sparseYellow,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.viewPaddingOf(context).top + 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildUserInfoCard(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = menuItems[index];

                  return _buildMenuItemButton(
                    title: item.title,
                    onClicked: item.onClicked,
                  );
                },
                separatorBuilder: (context, child) {
                  return const SizedBox(height: 13);
                },
                itemCount: menuItems.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoCard() {
    final profileImage = widget.profileImage;
    final nickname = widget.nickname;

    return GestureDetector(
      onTap: widget.onEditProfileButtonClicked,
      child: Row(
        spacing: 13,
        children: [
          Container(
            width: 87.79,
            height: 87.79,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: profileImage != null
                ? FutureImage(
                    imageFuture: profileImage,
                    width: 87.79,
                    height: 87.79,
                  )
                : null,
          ),
          Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nickname ?? "",
                style: TextStyle(
                  color: ThemeColors.grey800,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "어디로와 함께라면\n어디든 문제 없을 거에요!",
                style: TextStyle(
                  color: ThemeColors.grey500,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItemButton({
    required String title,
    required VoidCallback onClicked,
  }) {
    return GestureDetector(
      onTap: onClicked,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: ThemeColors.grey100,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: ThemeColors.grey800, width: 0.6),
        ),
        child: Row(
          spacing: 16,
          children: [
            SvgPicture.asset(
              "assets/images/ic_next_square.svg",
              package: "mypage",
              width: 30.04,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: ThemeColors.grey800,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
