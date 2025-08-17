import 'package:di/di.dart';
import 'package:data/sources/tmap/services/tmap_api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/web.dart';

void main() async {
  configureDependencies();

  await dotenv.load(fileName: ".env");
  String apiKey = dotenv.env["TMAP_API_KEY"]!;

  final logger = Logger(printer: PrettyPrinter());
  final tmapApiService = locator.get<TmapApiService>();

  // 숭실대입구역 (경도: 126.9535, 위도: 37.4965)
  const double startX = 126.9535;
  const double startY = 37.4965;

  // 이수역 (경도: 126.9822, 위도: 37.4854)
  const double endX = 126.9822;
  const double endY = 37.4854;

  logger.d("TMAP 도보 경로 API 테스트를 시작합니다.");

  try {
    final response = await tmapApiService.getPedestrianRoute(
      appKey: apiKey,
      startX: startX,
      startY: startY,
      endX: endX,
      endY: endY,
      startName: "숭실대입구역",
      endName: "이수역",
    );

    final summary = response.features.first.properties;

    if (summary.totalTime != null && summary.totalDistance != null) {
      final totalMinutes = (summary.totalTime! / 60).ceil();
      final totalKm = (summary.totalDistance! / 1000).toStringAsFixed(2);

      logger.d(
        [
          "경로 탐색 성공!",
          "총 소요 시간: 약 $totalMinutes분",
          "총 거리: ${totalKm}km",
        ].join("\n"),
      );
    } else {
      logger.d("경로를 찾았지만 요약 정보(시간, 거리)가 없습니다.");
    }
  } catch (e) {
    logger.d(["API 호출 중 에러가 발생했습니다.", e.toString()].join("\n"));
  }
}
