import 'package:injectable/injectable.dart';
import 'package:openapi/openapi.dart';

@module
abstract class OpenapiModule {
  @lazySingleton
  Openapi getOpenapi({
    @Named("base_url") required String baseUrl,
  }) {
    return Openapi(basePathOverride: baseUrl);
  }
}
