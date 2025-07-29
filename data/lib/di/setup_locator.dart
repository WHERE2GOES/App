import 'package:data/di/locator.dart';
import 'package:data/sources/tmap/services/tmap_api_service.dart';
import 'package:dio/dio.dart';

void setupLocator() {
  // Dio
  locator.registerLazySingleton<Dio>(() => Dio());

  // TmapApiService
  locator.registerLazySingleton<TmapApiService>(() {
    final dio = locator<Dio>();
    return TmapApiService(dio);
  });
}
