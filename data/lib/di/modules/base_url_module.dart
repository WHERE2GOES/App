import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@module
abstract class BaseUrlModule {
  @Named("base_url")
  @singleton
  @preResolve
  Future<String> get baseUrl async {
    if (!dotenv.isInitialized) await dotenv.load();
    return dotenv.get("SERVER_BASE_URL");
  }
}
