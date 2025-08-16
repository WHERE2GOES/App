import 'package:injectable/injectable.dart';

@module
abstract class BaseUrlModule {
  @Named("base_url")
  @singleton
  String get baseUrl => "";
}
