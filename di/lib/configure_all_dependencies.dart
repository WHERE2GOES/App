// ignore_for_file: library_prefixes

import 'package:di/configure_env.dart';
import 'package:home/di/configure_dependencies.dart' as configureHome;
import 'package:login/di/configure_dependencies.dart' as configureLogin;
import 'package:data/di/configure_dependencies.dart' as configureData;

Future<void> configureAllDependencies() async {
  await configureEnv();

  await configureData.configureDependencies();
  await configureHome.configureDependencies();
  await configureLogin.configureDependencies();
}