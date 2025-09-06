import 'package:di/configure_all_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home/apps/home_app.dart';
import 'package:home/vms/home_view_model.dart';

void main() async {
  await configureAllDependencies();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: "Pretendard"),
      home: Scaffold(
        body: HomeApp(
          vm: GetIt.I<HomeViewModel>(),
          onCurrentCourseCardClicked: () {},
        ),
      ),
    ),
  );
}
