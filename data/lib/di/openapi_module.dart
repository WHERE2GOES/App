import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:openapi/openapi.dart';

@module
abstract class OpenapiModule {
  @named
  @singleton
  Openapi getOpenapi({
    @Named.from(Dio) required Dio dio,
    @Named("base_url") required String baseUrl,
  }) {
    return Openapi(dio: dio, basePathOverride: baseUrl);
  }
}
