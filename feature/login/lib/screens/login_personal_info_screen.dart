import 'dart:typed_data';

import 'package:design/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class LoginPersonalInfoScreen extends StatefulWidget {
  const LoginPersonalInfoScreen({
    super.key,
    required this.profileImage,
    required this.nicknameController,
    required this.errorMessage,
    required this.onSelectPictureButtonClicked,
    required this.onClearProfileImageButtonClicked,
    required this.onClearNicknameButtonClicked,
    required this.onSubmitButtonClicked,
  });

  final Uint8List? profileImage;
  final TextEditingController nicknameController;
  final String? errorMessage;
  final VoidCallback onSelectPictureButtonClicked;
  final VoidCallback? onClearProfileImageButtonClicked;
  final VoidCallback? onClearNicknameButtonClicked;
  final VoidCallback onSubmitButtonClicked;

  @override
  State<LoginPersonalInfoScreen> createState() =>
      _LoginPersonalInfoScreenState();
}

class _LoginPersonalInfoScreenState extends State<LoginPersonalInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final errorMessage = widget.errorMessage;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: ThemeColors.pastelYellow,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              spacing: 12.87,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: ThemeColors.grey800, width: 0.6),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "프로필을 설정해주세요",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: ThemeColors.grey800,
                        ),
                      ),
                      Text(
                        "프로필을 설정해면 서비스를 더욱 재밌게 즐길 수 있어요!",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: ThemeColors.grey800.withValues(alpha: 0.4),
                        ),
                      ),
                      Stack(children: []),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: ThemeColors.grey800,
                          width: 0.6,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        controller: widget.nicknameController,
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: ThemeColors.grey800,
                        ),
                      )
                    ),
                    if (errorMessage != null)
                      Text(
                        errorMessage,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: widget.onSelectPictureButtonClicked,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
