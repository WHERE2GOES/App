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
  Future<Result<void>> endCourse() {
    // TODO: implement endCourse
    throw UnimplementedError();
  }

  @override
  Future<Result<CourseInfoEntity>> getCourseInfo({
    required dynamic courseId,
  }) async {
    try {
      final data = await authPreference.callWithAuth(
        openapi: openapi,
        action: (accessToken) async {
          final api = openapi.getGPTAPIApi();
          final response = await api.getFullDetail(
            headers: {"Authorization": "Bearer $accessToken"},
            name: courseId,
          );
          return response.data!.data!;
        },
      );

      return Success(
        data: CourseInfoEntity(
          id: data.name!,
          courseName: data.name!,
          regionName: "",
          description: data.aiSummary!,
          bannerImage: getFutureFromImageUrl(data.imageUrl!),
          scores: data.weights!.entries.map((e) {
            return CourseScoreEntity(name: "", score: 0.0);
          }),
        ),
      );
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }

  @override
  Future<Result<List<CoursePropertyEntity>>> getCourseProperties({
    required dynamic courseId,
    required CoursePropertyType type,
    required int page,
    required int size,
  }) async {
    try {
      final areaName = "";

      final success = await authPreference.callWithAuth(
        openapi: openapi,
        action: (accessToken) async {
          final api = openapi.getFestivalControllerApi();

          switch (type) {
            case CoursePropertyType.food:
              final response = await api.getFood(
                headers: {"Authorization": "Bearer $accessToken"},
                areaName: areaName,
              );

              return Success(
                data: response.data!.data!.map((e) {
                  return CoursePropertyEntity(
                    image: getFutureFromImageUrl(e.firstimage!),
                    name: e.title!,
                    type: CoursePropertyType.food,
                  );
                }).toList(),
              );

            case CoursePropertyType.activity:
              final festivals = await api.getFestivals(
                headers: {"Authorization": "Bearer $accessToken"},
                areaName: areaName,
                startDate: Date.now().toString(),
              );

              final plays = await api.getPlay(
                headers: {"Authorization": "Bearer $accessToken"},
                areaName: areaName,
              );

              return Success(
                data: [
                  ...festivals.data!.data!.map((e) {
                    return CoursePropertyEntity(
                      image: getFutureFromImageUrl(e.firstimage!),
                      name: e.title!,
                      type: CoursePropertyType.activity,
                    );
                  }),
                  ...plays.data!.data!.map((e) {
                    return CoursePropertyEntity(
                      image: getFutureFromImageUrl(e.firstimage!),
                      name: e.title!,
                      type: CoursePropertyType.activity,
                    );
                  }),
                ],
              );

            case CoursePropertyType.photoSpot:
              final response = await api.getPhoto(
                headers: {"Authorization": "Bearer $accessToken"},
                areaName: areaName,
              );

              return Success(
                data: response.data!.data!.map((e) {
                  return CoursePropertyEntity(
                    image: getFutureFromImageUrl(e.firstimage!),
                    name: e.title!,
                    type: CoursePropertyType.photoSpot,
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
  Future<Result<CurrentCourseEntity?>> getCurrentCourse() {
    // TODO: implement getCurrentCourse
    throw UnimplementedError();
  }

  @override
  Future<Result<FittedCourseEntity>> getFittedCourses() {
    // TODO: implement getFittedCourses
    throw UnimplementedError();
  }

  @override
  Future<Result<List<RecommendedCourseEntity>>> getRecommendedCourses({
    required page,
    required size,
  }) async {
    try {
      final data = await authPreference.callWithAuth(
        openapi: openapi,
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
                id: e.name!,
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
  Future<Result<void>> startCourse({required dynamic courseId}) {
    // TODO: implement startCourse
    throw UnimplementedError();
  }
}
