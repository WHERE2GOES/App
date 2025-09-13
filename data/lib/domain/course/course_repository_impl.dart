import 'package:core/common/result.dart';
import 'package:core/domain/course/course_repository.dart';
import 'package:core/domain/course/model/course_info_entity.dart';
import 'package:core/domain/course/model/course_property_entity.dart';
import 'package:core/domain/course/model/course_property_type.dart';
import 'package:core/domain/course/model/course_score_entity.dart';
import 'package:core/domain/course/model/current_course_entity.dart';
import 'package:core/domain/course/model/fitted_course_entity.dart';
import 'package:core/domain/course/model/recommended_course_entity.dart';
import 'package:data/sources/local/auth_preference.dart';
import 'package:data/utils/call_with_auth.dart';
import 'package:data/utils/get_future_from_image_url.dart';
import 'package:injectable/injectable.dart';
import 'package:openapi/openapi.dart';

@LazySingleton(as: CourseRepository)
class CourseRepositoryImpl implements CourseRepository {
  final Openapi openapi;
  final AuthPreference authPreference;

  const CourseRepositoryImpl({
    required this.openapi,
    required this.authPreference,
  });

  @override
  Future<Result<CourseInfoEntity>> getCourseInfo({
    required int courseId,
  }) async {
    try {
      final data = await openapi.callWithAuth(
        authPreference: authPreference,
        action: (accessToken) async {
          final api = openapi.getGPTAPIApi();
          final response = await api.getFullDetail(
            headers: {"Authorization": "Bearer $accessToken"},
            courseId: courseId.toString(),
          );
          return response.data!.data!;
        },
      );

      return Success(
        data: CourseInfoEntity(
          id: courseId,
          courseName: data.name!,
          regionName: data.country!,
          description: data.aiSummary!,
          bannerImage: getFutureFromImageUrl(data.imageUrl!),
          scores: data.weights!.entries.map((e) {
            return CourseScoreEntity(name: e.key, score: e.value);
          }),
        ),
      );
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }

  @override
  Future<Result<List<CoursePropertyEntity>>> getCourseProperties({
    required int courseId,
    required CoursePropertyType type,
    required int page,
    required int size,
  }) async {
    try {
      final courseInfo = await getCourseInfo(courseId: courseId);

      if (courseInfo is! Success<CourseInfoEntity>) {
        return Failure(exception: Exception("코스 데이터를 불러오는 도중 오류가 발생했습니다."));
      }

      final success = await openapi.callWithAuth(
        authPreference: authPreference,
        action: (accessToken) async {
          final api = openapi.getFestivalControllerApi();

          switch (type) {
            case CoursePropertyType.food:
              final response = await api.getFood(
                headers: {"Authorization": "Bearer $accessToken"},
                areaName: courseInfo.data.regionName,
              );

              return Success(
                data: response.data!.data!.map((e) {
                  return CoursePropertyEntity(
                    image: getFutureFromImageUrl(e.firstimage!),
                    name: e.title!,
                    type: CoursePropertyType.food,
                    address: [
                      e.addr1,
                      e.addr2,
                    ].whereType<String>().where((e) => e.isNotEmpty).join(" "),
                    latitude: double.parse(e.mapy!),
                    longitude: double.parse(e.mapx!),
                  );
                }).toList(),
              );

            case CoursePropertyType.activity:
              final festivals = await api.getFestivals(
                headers: {"Authorization": "Bearer $accessToken"},
                areaName: courseInfo.data.regionName,
                startDate: Date.now().toString(),
              );

              final plays = await api.getPlay(
                headers: {"Authorization": "Bearer $accessToken"},
                areaName: courseInfo.data.regionName,
              );

              return Success(
                data: [
                  ...festivals.data!.data!.map((e) {
                    return CoursePropertyEntity(
                      image: getFutureFromImageUrl(e.firstimage!),
                      name: e.title!,
                      type: CoursePropertyType.activity,
                      address: [e.addr1, e.addr2]
                          .whereType<String>()
                          .where((e) => e.isNotEmpty)
                          .join(" "),
                      latitude: double.parse(e.mapy!),
                      longitude: double.parse(e.mapx!),
                    );
                  }),
                  ...plays.data!.data!.map((e) {
                    return CoursePropertyEntity(
                      image: getFutureFromImageUrl(e.firstimage!),
                      name: e.title!,
                      type: CoursePropertyType.activity,
                      address: [e.addr1, e.addr2]
                          .whereType<String>()
                          .where((e) => e.isNotEmpty)
                          .join(" "),
                      latitude: double.parse(e.mapy!),
                      longitude: double.parse(e.mapx!),
                    );
                  }),
                ],
              );

            case CoursePropertyType.photoSpot:
              final response = await api.getPhoto(
                headers: {"Authorization": "Bearer $accessToken"},
                areaName: courseInfo.data.regionName,
              );

              return Success(
                data: response.data!.data!.map((e) {
                  return CoursePropertyEntity(
                    image: getFutureFromImageUrl(e.firstimage!),
                    name: e.title!,
                    type: CoursePropertyType.photoSpot,
                    address: [
                      e.addr1,
                      e.addr2,
                    ].whereType<String>().where((e) => e.isNotEmpty).join(" "),
                    latitude: double.parse(e.mapy!),
                    longitude: double.parse(e.mapx!),
                  );
                }).toList(),
              );
          }
        },
      );

      return success;
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }

  @override
  Future<Result<CurrentCourseEntity?>> getCurrentCourse() async {
    // TODO: implement getCurrentCourse
    return Failure(exception: Exception());
  }

  @override
  Future<Result<List<FittedCourseEntity>>> getFittedCourses() async {
    try {
      final ids = await openapi.callWithAuth(
        authPreference: authPreference,
        action: (accessToken) async {
          final api = openapi.getSurveyControllerApi();
          final response = await api.getRecommendations(
            headers: {"Authorization": "Bearer $accessToken"},
          );

          return response.data?.data?.recommendedCourseIds?.asList();
        },
      );

      if (ids == null) {
        return Failure(exception: Exception("맞춤 코스가 없습니다."));
      }

      final responses = await openapi.callWithAuth(
        authPreference: authPreference,
        action: (accessToken) async {
          final api = openapi.getGPTAPIApi();

          final responses = await Future.wait(
            ids.map((id) async {
              try {
                return await api.getFullDetail(
                  courseId: id.toString(),
                  headers: {"Authorization": "Bearer $accessToken"},
                );
              } on Exception catch (_) {
                return null;
              }
            }),
          );

          return responses.where((e) => e != null).toList();
        },
      );

      return Success(
        data: responses
            .map(
              (e) => FittedCourseEntity(
                id: int.parse(e!.data!.data!.courseId!),
                name: e.data!.data!.name!,
              ),
            )
            .toList(),
      );
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }

  @override
  Future<Result<List<RecommendedCourseEntity>>> getRecommendedCourses({
    required page,
    required size,
  }) async {
    try {
      final data = await openapi.callWithAuth(
        authPreference: authPreference,
        action: (accessToken) async {
          final api = openapi.getGPTAPIApi();
          final response = await api.callGet(
            headers: {"Authorization": "Bearer $accessToken"},
          );
          return response.data?.data?.top3?.asList();
        },
      );

      return Success(
        data: data!
            .map(
              (e) => RecommendedCourseEntity(
                id: int.parse(e.courseId!),
                name: e.name!,
                image: getFutureFromImageUrl(e.imageUrl!),
              ),
            )
            .toList(),
      );
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }

  @override
  Future<Result<void>> startCourse({required int courseId}) async {
    try {
      final isSucceed = await openapi.callWithAuth(
        authPreference: authPreference,
        action: (accessToken) async {
          final api = openapi.getCourseControllerApi();
          final req = CourseStartReq((b) => b..courseId = courseId);
          final response = await api.startCourse(
            courseStartReq: req,
            headers: {"Authorization": "Bearer $accessToken"},
          );
          return response.statusCode == 200;
        },
      );

      if (!isSucceed) throw Exception("코스가 시작되지 않았습니다.");
      return Success(data: null);
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }

  @override
  Future<Result<void>> endCourse() async {
    try {
      final isSucceed = await openapi.callWithAuth(
        authPreference: authPreference,
        action: (accessToken) async {
          final api = openapi.getCourseControllerApi();
          final response = await api.endCourse(
            headers: {"Authorization": "Bearer $accessToken"},
          );

          return response.statusCode == 200;
        },
      );

      if (!isSucceed) throw Exception("코스를 끝내지 못했습니다.");
      return Success(data: null);
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }
}
