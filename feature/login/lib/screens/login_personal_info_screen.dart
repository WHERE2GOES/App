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
    final onClearNicknameButtonClicked = widget.onClearNicknameButtonClicked;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: ThemeColors.pastelYellow,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
                    spacing: 5,
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
                        child: Row(
                          spacing: 10,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: widget.nicknameController,
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600,
                                  color: ThemeColors.grey800,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            if (onClearNicknameButtonClicked != null)
                              GestureDetector(
                                onTap: onClearNicknameButtonClicked,
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Center(child: Text("X")),
                                ),
                              ),
                          ],
                        ),
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
              GestureDetector(
                onTap: widget.onSubmitButtonClicked,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "시작하기",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
