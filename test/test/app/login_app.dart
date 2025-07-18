import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:login/apps/login_app.dart';

void main() {
  KakaoSdk.init(nativeAppKey: '5def7287d22fe0861d08d2de8bbbc553');

  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: "Pretendard"),
      home: LoginApp(onLoginSucceeded: () {}),
    ),
  );
}
