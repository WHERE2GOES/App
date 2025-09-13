import 'package:design/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashApp extends StatelessWidget {
  const SplashApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go("/login");
    });

    return Container(color: ThemeColors.pastelYellow);
  }
}
