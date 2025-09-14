import 'package:design/theme/theme_colors.dart';
import 'package:design/widget/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RewardCertificationScreen extends StatefulWidget {
  const RewardCertificationScreen({
    super.key,
    required this.certificateOrder,
    required this.onBackButtonClicked,
    required this.onCameraButtonClicked,
  });

  final int certificateOrder; // 1부터 시작
  final VoidCallback onBackButtonClicked;
  final VoidCallback onCameraButtonClicked;

  @override
  State<RewardCertificationScreen> createState() =>
      _RewardCertificationScreenState();
}

class _RewardCertificationScreenState extends State<RewardCertificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
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
      child: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: GestureDetector(
                    onTap: widget.onBackButtonClicked,
                    child: SvgPicture.asset(
                      "assets/images/img_back_button.svg",
                      package: "reward",
                      width: 40.33,
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    spacing: 19.53,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: ThemeColors.sparseYellow,
                          borderRadius: BorderRadius.circular(5.96),
                          border: Border.all(
                            color: ThemeColors.grey800,
                            width: 0.72,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${widget.certificateOrder}번째",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Text(" "),
                            Text(
                              "인증센터",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: ThemeColors.grey500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 29.3,
                          horizontal: 22.4,
                        ),
                        decoration: BoxDecoration(
                          color: ThemeColors.sparseYellow,
                          borderRadius: BorderRadius.circular(5.96),
                          border: Border.all(
                            color: ThemeColors.grey800,
                            width: 0.72,
                          ),
                        ),
                        child: Column(
                          spacing: 18.92,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(23.8),
                              decoration: BoxDecoration(
                                color: ThemeColors.pastelYellow,
                                borderRadius: BorderRadius.circular(5.96),
                                border: Border.all(
                                  color: ThemeColors.grey800,
                                  width: 0.72,
                                ),
                              ),
                              child: Center(
                                child: Image.asset(
                                  "assets/images/img_certification_big.png",
                                  package: "reward",
                                  width: 102.46,
                                ),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${widget.certificateOrder}번째 인증센터",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: ThemeColors.grey800,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "에 오신걸 환영합니다!",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: ThemeColors.grey500,
                                    ),
                                  ),
                                  TextSpan(text: "\n"),
                                  TextSpan(
                                    text: "큐알코드를 찍고 인증을 완료해보세요!",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: ThemeColors.grey500,
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
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomBottomSheet(
              showDragHandle: false,
              initialHeight: 128 + MediaQuery.of(context).viewPadding.bottom,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 23),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "큐알코드를",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: ThemeColors.pastelYellow,
                                  ),
                                ),
                                TextSpan(
                                  text: " 찍어볼까요?",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.onCameraButtonClicked,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Color(0xFF61615C),
                              borderRadius: BorderRadius.circular(5.96),
                              border: Border.all(
                                color: ThemeColors.pastelGreen.withValues(
                                  alpha: 0.4,
                                ),
                                width: 0.6,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "카메라 실행하기",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
