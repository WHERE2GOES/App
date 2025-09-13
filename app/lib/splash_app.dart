import 'package:core/common/result.dart';
import 'package:core/domain/auth/auth_repository.dart';
import 'package:design/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class SplashApp extends StatefulWidget {
  const SplashApp({super.key});

  @override
  State<SplashApp> createState() => _SplashAppState();
}

class _SplashAppState extends State<SplashApp> {
  final AuthRepository _authRepository = GetIt.I<AuthRepository>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));

      final result = await _authRepository.isLoggedIn;

      if (result is Success<bool> && result.data) {
        _navigateToHome();
      } else {
        _navigateToLogin();
      }
    });

    return Container(
      color: ThemeColors.pastelYellow,
      child: Center(
        child: Image.asset(
          "assets/images/logo.png",
          package: "design",
          width: 145.78,
        ),
      ),
    );
  }

  void _navigateToLogin() {
    if (mounted) context.go("/login");
  }

  void _navigateToHome() {
    if (mounted) context.go("/home");
  }
}
