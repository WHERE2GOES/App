import 'package:di/configure_all_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:login/apps/login_app.dart';
import 'package:login/vms/login_view_model.dart';

void main() async {
  await configureAllDependencies();

  KakaoSdk.init(nativeAppKey: '5def7287d22fe0861d08d2de8bbbc553');

  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: "Pretendard"),
      home: LoginApp(
        vm: GetIt.I<LoginViewModel>(),
        onLoginSucceeded: () {},
      ),
    ),
  );
}
