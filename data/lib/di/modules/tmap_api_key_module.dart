import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@module
abstract class TmapApiKeyModule {
  @Named("tmap_api_key")
  @singleton
  @preResolve
  Future<String> get tmapApiKey async {
    if (!dotenv.isInitialized) throw Exception("Dotenv is not initialized");
    return dotenv.get("TMAP_API_KEY");
  }
}
