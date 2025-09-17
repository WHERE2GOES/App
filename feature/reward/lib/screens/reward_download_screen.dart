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
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
            Padding(
              padding: const EdgeInsets.all(24),
              child: GestureDetector(
                onTap: widget.onDownloadButtonClicked,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    border: Border.all(color: ThemeColors.grey800, width: 0.6),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Click",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
