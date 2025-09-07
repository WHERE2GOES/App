import 'package:design/theme/theme_colors.dart';
import 'package:design/widget/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginCoursePreferencesStartScreen extends StatefulWidget {
  const LoginCoursePreferencesStartScreen({
    super.key,
    required this.onStartButtonClicked,
  });

  final VoidCallback onStartButtonClicked;

  @override
  State<LoginCoursePreferencesStartScreen> createState() =>
      _LoginCoursePreferencesStartScreenState();
}

class _LoginCoursePreferencesStartScreenState
    extends State<LoginCoursePreferencesStartScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.pastelYellow,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: SvgPicture.asset(
                "assets/images/img_preference_question_logo.svg",
                package: "login",
                width: 216.8,
              ),
            ),
          ),
          CustomBottomSheet(
            showDragHandle: false,
            initialHeight: 128 + MediaQuery.of(context).padding.bottom,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 33.5,
                  child: SvgPicture.asset(
                    "assets/images/img_start_bottom_sheet_deco1.svg",
                    package: "login",
                    width: 74.11,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 34.53,
                  child: SvgPicture.asset(
                    "assets/images/img_start_bottom_sheet_deco2.svg",
                    width: 92.19,
                    package: "login",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 23,
                    left: 24,
                    right: 24,
                    bottom: 24,
                  ),
                  child: Column(
                    spacing: 21,
                    children: [
                      Text(
                        "유형테스트를 동해 맞춤형 코스를 추천해줄게요",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: widget.onStartButtonClicked,
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 37.24,
                          decoration: BoxDecoration(
                            color: Color(0xFF61615C),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: ThemeColors.pastelGreen.withValues(
                                alpha: 0.4,
                              ),
                              width: 0.6,
                            ),
                          ),
                          child: Text(
                            "검사 시작하기",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
