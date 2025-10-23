import 'package:design/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class CourseTerminationConfirmPopup extends StatelessWidget {
  const CourseTerminationConfirmPopup({
    super.key,
    required this.onCancelClicked,
    required this.onOkClicked,
  });

  final VoidCallback onCancelClicked;
  final VoidCallback onOkClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: ThemeColors.grey800.withValues(alpha: 0.4),
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: ThemeColors.sparseOrange,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          spacing: 40,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "코스를 종료하시겠습니까?",
              style: TextStyle(
                color: ThemeColors.grey800,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            Text(
              "다음에 언제든 다시 시작할 수 있습니다."
                  .replaceAllMapped(
                    RegExp(r'(\S)(?=\S)'),
                    (m) => '${m[1]}\u200D',
                  ),
              style: TextStyle(
                color: ThemeColors.grey800,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onCancelClicked,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ThemeColors.grey500,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "취소",
                        style: TextStyle(
                          color: ThemeColors.pastelYellow,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: onOkClicked,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ThemeColors.grey800,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "확인",
                        style: TextStyle(
                          color: ThemeColors.pastelYellow,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
