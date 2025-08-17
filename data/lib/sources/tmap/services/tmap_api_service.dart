import 'package:data/sources/tmap/objects/pedestrian_route_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'tmap_api_service.g.dart';

@RestApi(baseUrl: "https://apis.openapi.sk.com")
abstract class TmapApiService {
  factory TmapApiService(Dio dio, {String baseUrl}) = _TmapApiService;

  @POST("/tmap/routes/pedestrian")
  @FormUrlEncoded()
  Future<PedestrianRouteResponse> getPedestrianRoute({
    @Header("appKey") required String appKey,
    @Field("startX") required double startX,
    @Field("startY") required double startY,
    @Field("endX") required double endX,
    @Field("endY") required double endY,
    @Field("reqCoordType") String reqCoordType = "WGS84GEO",
    @Field("startName") required String startName,
    @Field("endName") required String endName,
  });
}
