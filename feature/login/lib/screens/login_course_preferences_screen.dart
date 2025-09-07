import 'package:design/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginCoursePreferencesScreen extends StatefulWidget {
  const LoginCoursePreferencesScreen({
    super.key,
    required this.totalSteps,
    required this.step,
    required this.question,
    required this.options,
    required this.onBackButtonClicked,
    required this.onNextButtonClicked,
  });

  final int totalSteps;
  final int step; // zero-based index
  final String question;
  final List<({String option, VoidCallback onClicked})> options;
  final VoidCallback onBackButtonClicked;
  final VoidCallback? onNextButtonClicked;

  @override
  State<LoginCoursePreferencesScreen> createState() =>
      _LoginCoursePreferencesScreenState();
}

class _LoginCoursePreferencesScreenState
    extends State<LoginCoursePreferencesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFAFFEC).withValues(alpha: 0.0),
            Color(0xFFF2FFCD).withValues(alpha: 1.0),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 37),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "당신의 ",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: ThemeColors.grey800,
                  ),
                ),
                TextSpan(
                  text: "국토대장정 취향",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: ThemeColors.highlightedRed,
                  ),
                ),
                TextSpan(
                  text: "은?",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: ThemeColors.grey800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 52),
          Container(
            constraints: BoxConstraints(maxWidth: 200),
            child: Row(
              spacing: 14.55,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: widget.onBackButtonClicked,
                  child: Image.asset(
                    "assets/images/img_back_button.png",
                    package: "login",
                    width: 20.9,
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: 1,
                    children: [
                      Text(
                        "${widget.step + 1} / ${widget.totalSteps}",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors.grey800,
                        ),
                      ),
                      Container(
                        height: 5.45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: ThemeColors.grey800,
                            width: 0.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: widget.onNextButtonClicked,
                  child: Image.asset(
                    "assets/images/img_next_button.png",
                    package: "login",
                    width: 20.9,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 68),
          SvgPicture.asset(
            "assets/images/img_human_with_deco.svg",
            package: "login",
            width: 169.59,
          ),
          const SizedBox(height: 72),
          Text(
            widget.question,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: ThemeColors.grey800,
            ),
          ),
          const SizedBox(height: 0),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final option = widget.options[index];

              return GestureDetector(
                onTap: option.onClicked,
                child: Container(
                  width: double.infinity,
                  height: 97.25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9E1C0),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: ThemeColors.grey800, width: 0.6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          option.option,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: ThemeColors.grey800,
                          ),
                        ),
                        Image.asset(
                          "assets/images/ic_triangle_right.png",
                          package: "login",
                          width: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 12),
            itemCount: widget.options.length,
          ),
        ],
      ),
    );
  }
}
