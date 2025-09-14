import 'package:collection/collection.dart';
import 'package:design/theme/theme_colors.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:reward/models/reward_node_type.dart';

class RewardRoadScreen extends StatefulWidget {
  const RewardRoadScreen({
    super.key,
    required this.certificates,
    required this.completeButton,
  });

  final List<({bool isCompleted, VoidCallback onClicked})>? certificates;
  final ({VoidCallback onClicked})? completeButton;

  @override
  State<RewardRoadScreen> createState() => _RewardRoadScreenState();
}

class _RewardRoadScreenState extends State<RewardRoadScreen> {
  @override
  Widget build(BuildContext context) {
    final certificates = widget.certificates;

    final nodes = certificates != null
        ? [
            (type: RewardNodeType.start, isCompleted: false, onClicked: null),
            ...certificates.map(
              (e) => (
                type: RewardNodeType.certificate,
                isCompleted: e.isCompleted,
                onClicked: e.onClicked,
              ),
            ),
            (
              type: RewardNodeType.end,
              isCompleted: widget.completeButton != null,
              onClicked: widget.completeButton?.onClicked,
            ),
          ]
        : null;

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
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).viewPadding.top + 115),
            Column(
              spacing: 15,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  package: "design",
                  width: 145.78,
                ),
                Image.asset(
                  "assets/images/img_phrase.png",
                  package: "reward",
                  width: 216,
                ),
              ],
            ),
            SizedBox(height: 30),
            if (nodes != null)
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final first = nodes[index * 3];
                  final second = index * 3 + 1 < nodes.length
                      ? nodes[index * 3 + 1]
                      : null;
                  final third = index * 3 + 2 < nodes.length
                      ? nodes[index * 3 + 2]
                      : null;
                  final fourth = index * 3 + 3 < nodes.length
                      ? nodes[index * 3 + 3]
                      : null;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        children: [first, second, third, fourth].mapIndexed((
                          index,
                          e,
                        ) {
                          final line = _buildLine(
                            isCompletedLine: e?.type == RewardNodeType.start
                                ? null
                                : e?.isCompleted,
                          );

                          return index == 0 || index == 3
                              ? SizedBox(width: 60, child: line)
                              : Expanded(child: line);
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildNode(node: first),
                            _buildNode(node: second),
                            _buildNode(node: third),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 51.11);
                },
                itemCount: (nodes.length / 3.0).ceil(),
              ),
            SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 24),
          ],
        ),
      ),
    );
  }

  Widget _buildNode({
    required ({
      RewardNodeType type,
      bool? isCompleted,
      VoidCallback? onClicked,
    })?
    node,
  }) {
    return node != null
        ? GestureDetector(
            onTap: node.onClicked,
            child: Container(
              width: 65.34,
              height: 65.34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: switch (node.type) {
                  RewardNodeType.start => ThemeColors.pastelYellow,
                  RewardNodeType.certificate =>
                    node.isCompleted == true
                        ? ThemeColors.pastelYellow
                        : Color(0xFFE4EEC6),
                  RewardNodeType.end =>
                    node.isCompleted == true
                        ? ThemeColors.highlightedRed
                        : Color(0xFF989B8E),
                },
                border: Border.all(color: ThemeColors.grey800, width: 0.5),
              ),
              child: Center(
                child: switch (node.type) {
                  RewardNodeType.start => Text("Start"),
                  RewardNodeType.certificate =>
                    node.isCompleted == true
                        ? Image.asset(
                            "assets/images/img_certification_completed.png",
                            package: "reward",
                            width: 29.93,
                          )
                        : Image.asset(
                            "assets/images/img_certification_not_completed.png",
                            package: "reward",
                            width: 29.93,
                          ),
                  RewardNodeType.end =>
                    node.isCompleted == true
                        ? Image.asset(
                            "assets/images/img_trophy_completed.png",
                            package: "reward",
                            width: 39,
                          )
                        : Image.asset(
                            "assets/images/img_trophy_not_completed.png",
                            package: "reward",
                            width: 39,
                          ),
                },
              ),
            ),
          )
        : const SizedBox(width: 65.34, height: 65.34);
  }

  Widget _buildLine({required bool? isCompletedLine}) {
    return isCompletedLine != null
        ? Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 23.19,
                decoration: BoxDecoration(
                  color: isCompletedLine
                      ? ThemeColors.pastelGreen
                      : Color(0xFFD9E1C0),
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: isCompletedLine
                          ? Color(0xFFAFD53C)
                          : Color(0xFF787878),
                      width: 0.5,
                    ),
                  ),
                ),
              ),
              DottedLine(
                dashColor: isCompletedLine
                    ? Color(0xFFFDC453)
                    : Color(0xFFB1B1B1),
                lineThickness: 0.5,
                dashLength: 5,
                dashGapLength: 4,
              ),
            ],
          )
        : SizedBox.shrink();
  }
}
