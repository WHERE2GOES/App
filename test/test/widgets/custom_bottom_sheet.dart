import 'package:design/theme/theme_fonts.dart';
import 'package:design/widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: ThemeFonts.pretendard),
      home: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            child: CustomBottomSheet(
              child: Container(
                height: 500,
                color: Colors.green,
                child: Center(child: Text("test")),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
