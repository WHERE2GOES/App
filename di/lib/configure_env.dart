import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> configureEnv() async {
  await dotenv.load(fileName: "packages/di/../.env");
}