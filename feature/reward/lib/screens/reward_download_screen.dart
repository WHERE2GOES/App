import 'package:design/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class RewardDownloadScreen extends StatefulWidget {
  const RewardDownloadScreen({
    super.key,
    required this.onDownloadButtonClicked,
  });

  final VoidCallback onDownloadButtonClicked;

  @override
  State<RewardDownloadScreen> createState() => _RewardDownloadScreenState();
}

class _RewardDownloadScreenState extends State<RewardDownloadScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.highlightedRed,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Text(
                    "카톡 테마를 다운받아보세요!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Image.asset(
                    "assets/images/img_trophy_big.png",
                    package: "reward",
                    width: 181.74,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: widget.onDownloadButtonClicked,
            child: Container(
              color: Colors.white.withValues(alpha: 0.2),
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: ThemeColors.grey800, width: 0.6),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "Click",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
