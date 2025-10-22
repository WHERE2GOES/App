import 'package:design/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class LocationPermissionPopup extends StatelessWidget {
  const LocationPermissionPopup({super.key, required this.onOkClicked});

  final VoidCallback onOkClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: ThemeColors.grey800.withValues(alpha: 0.4),
      child: Container(
        width: 300,
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
              "위치 정보 권한 안내",
              style: TextStyle(
                color: ThemeColors.grey800,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            Text(
              "이 앱은 지도 위에서 사용자의 위치를 보여주고 주변 장소 검색 및 길찾기 기능을 제공하기 위해서 위치 정보를 사용합니다.\n\n"
                      "이 기능을 사용하려면 위치 권한을 허용해주세요."
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
            GestureDetector(
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
          ],
        ),
      ),
    );
  }
}
