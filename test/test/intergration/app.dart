import 'package:design/theme/theme_colors.dart';
import 'package:di/configure_all_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home/apps/home_app.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:login/apps/login_app.dart';
import 'package:navigation/apps/navigation_app.dart';

void main() async {
  await configureAllDependencies();

  await dotenv.load(fileName: ".env");
  String kakaoAppKey = dotenv.env["KAKAO_APP_KEY"]!;
  String googleServerClientId = dotenv.env["GOOGLE_SERVER_CLIENT_ID"]!;

  KakaoSdk.init(nativeAppKey: kakaoAppKey);
  await GoogleSignIn.instance.initialize(serverClientId: googleServerClientId);

  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => _TestSplashScreen()),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginApp(
          onLoginSucceeded: () {
            context.go("/home");
          },
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
        ),
      ),
      GoRoute(
        path: '/navigation',
        builder: (context, state) {
          final latlngs = state.uri.queryParameters["latlngs"];

          return NavigationApp(initialCoursePositionString: latlngs);
        },
      ),
    ],
  );

  runApp(
    MaterialApp.router(
      theme: ThemeData(fontFamily: "Pretendard"),
      routerConfig: router,
      builder: (context, child) => Scaffold(body: child),
    ),
  );
}

class _TestSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go("/login");
    });

    return Container(color: ThemeColors.pastelOrange);
  }
}
