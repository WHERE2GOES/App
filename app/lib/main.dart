import 'package:app/app.dart';
import 'package:app/route_handler.dart';
import 'package:di/configure_all_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

void main() async {
  await configureAllDependencies();

  String kakaoAppKey = dotenv.env["KAKAO_APP_KEY"]!;
  String googleServerClientId = dotenv.env["GOOGLE_SERVER_CLIENT_ID"]!;

  KakaoSdk.init(nativeAppKey: kakaoAppKey);
  await GoogleSignIn.instance.initialize(serverClientId: googleServerClientId);

  runApp(
    MaterialApp.router(
      theme: ThemeData(fontFamily: "Pretendard"),
      themeAnimationStyle: AnimationStyle.noAnimation,
      routerConfig: RouteHandler.router,
      builder: (context, child) =>
          App(key: ValueKey("root"), router: RouteHandler.router, child: child),
    ),
  );
}
