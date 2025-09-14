import 'package:app/splash_app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:home/apps/home_app.dart';
import 'package:login/apps/login_app.dart';
import 'package:mypage/apps/my_page_app.dart';
import 'package:navigation/apps/navigation_app.dart';

class RouteHandler {
  static VoidCallback? _backHandler;

  static void setBackHandler(VoidCallback handler) {
    _backHandler = handler;
  }

  static void clearBackHandler() {
    _backHandler = null;
  }

  static void back() {
    _backHandler?.call();
  }

  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashApp()),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginApp(
          vm: GetIt.I(),
          onLoginSucceeded: () {
            context.go("/home");
          },
          onBack: RouteHandler.back,
        ),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeApp(
          vm: GetIt.I(),
          onCurrentCourseCardClicked: () {
            context.go("/navigation");
          },
          onCourseStarted: () {
            context.go("/navigation");
          },
          onBack: RouteHandler.back,
        ),
      ),
      GoRoute(
        path: '/navigation',
        builder: (context, state) {
          return NavigationApp(vm: GetIt.I(), onBack: RouteHandler.back);
        },
      ),
      GoRoute(
        path: '/mypage',
        builder: (context, state) {
          return MyPageApp(
            vm: GetIt.I(),
            onLogout: () {
              context.go("/login");
            },
            onBack: RouteHandler.back,
          );
        },
      ),
    ],
  );
}
