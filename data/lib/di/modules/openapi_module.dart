import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:openapi/openapi.dart';

@module
abstract class OpenapiModule {
  @lazySingleton
  Openapi getOpenapi({
    required Dio dio,
    @Named("base_url") required String baseUrl,
  }) {
    return Openapi(dio: dio, basePathOverride: baseUrl);
  }
}
