import 'package:data/sources/tmap/services/tmap_api_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class TmapApiServiceModule {
  @lazySingleton
  TmapApiService getTmapApiService({required Dio dio}) {
    return TmapApiService(dio);
  }
}
