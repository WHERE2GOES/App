import 'package:data/sources/tmap/services/tmap_api_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class TmapApiServiceModule {
  @named
  @lazySingleton
  TmapApiService getTmapApiService({
    @Named.from(Dio) required Dio dio,
    @Named("base_url") required String baseUrl,
  }) {
    return TmapApiService(dio, baseUrl: baseUrl);
  }
}
