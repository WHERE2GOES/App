import 'package:built_collection/built_collection.dart';
import 'package:core/common/result.dart';
import 'package:core/domain/user/model/course_preference_type.dart';
import 'package:core/domain/user/model/preference_question_entity.dart';
import 'package:core/domain/user/model/preference_update_requrest.dart';
import 'package:core/domain/user/model/profile_update_request.dart';
import 'package:core/domain/user/model/sign_up_request.dart';
import 'package:core/domain/user/model/user_entity.dart';
import 'package:core/domain/user/user_repository.dart';
import 'package:data/sources/local/auth_preference.dart';
import 'package:data/utils/call_with_auth.dart';
import 'package:data/utils/get_future_from_image_url.dart';
import 'package:injectable/injectable.dart';
import 'package:openapi/openapi.dart' as O;

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final O.Openapi openapi;
  final AuthPreference authPreference;

  const UserRepositoryImpl({
    required this.openapi,
    required this.authPreference,
  });

  @override
  Future<Result<List<PreferenceQuestionEntity>>>
  getPreferenceQuestions() async {
    try {
      final questions = await openapi.callWithAuth(
        authPreference: authPreference,
        action: (accessToken) async {
          final api = openapi.getSurveyControllerApi();
          final response = await api.questions(
            headers: {"Authorization": "Bearer $accessToken"},
          );

          return response.data!.toList();
        },
      );

      return Success(
        data: questions
            .map(
              (e) => PreferenceQuestionEntity(
                id: e.id!,
                question: e.axis!,
                options: [e.leftLabel!, e.rightLabel!],
              ),
            )
            .toList(),
      );
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }

  @override
  Future<Result<CoursePreferenceType>> getCoursePreferenceType() async {
    // TODO: implement getCoursePreferenceType
    return Failure(exception: Exception("Not implemented"));
  }

  @override
  Future<Result<UserEntity>> getUserInfo() async {
    try {
      final user = await openapi.callWithAuth(
        authPreference: authPreference,
        action: (accessToken) async {
          final api = openapi.getLoginAPIApi();
          final response = await api.getMypage(
            headers: {"Authorization": "Bearer $accessToken"},
          );

          return response.data!.data!;
        },
      );

      return Success(
        data: UserEntity(
          nickname: user.name!,
          email: null, // TODO: 백엔드 지원 시 교체
          profileImage: user.profileImg != null
              ? getFutureFromImageUrl(user.profileImg!)
              : null,
        ),
      );
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }

  @override
  Future<Result<void>> signUp({required SignUpRequest request}) async {
    try {
      final api = openapi.getLoginAPIApi();
      final email = await authPreference.pendingEmail;
      final domain = await authPreference.pendingEmailDomain;

      final body = O.SignUpRequest(
        (b) => b
          ..domain = domain
          ..email = email
          ..name = request.nickname,
      );

      final response = await api.signUp(signUpRequest: body);

      await authPreference.setAccessToken(response.data!.data!.accessToken!);
      await authPreference.setRefreshToken(response.data!.data!.refreshToken!);

      await updatePreference(
        request: PreferenceUpdateRequest(preferences: request.preferences),
      );

      return Success(data: null);
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }

  @override
  Future<Result<void>> updatePreference({
    required PreferenceUpdateRequest request,
  }) async {
    try {
      final isSucceed = await openapi.callWithAuth(
        authPreference: authPreference,
        action: (accessToken) async {
          final api = openapi.getSurveyControllerApi();
          final body = O.AnswerReq(
            (b) => b
              ..answers = ListBuilder(
                request.preferences.map(
                  (e) => O.AnswerDto(
                    (b) => b
                      ..questionId = e.questionId
                      ..choice = switch (e.selectedOptionIndex) {
                        0 => "left",
                        1 => "right",
                        _ => throw Exception("가능하지 않은 선택지입니다."),
                      },
                  ),
                ),
              ),
          );

          final response = await api.save(
            answerReq: body,
            headers: {"Authorization": "Bearer $accessToken"},
          );

          return response.statusCode == 200;
        },
      );

      if (!isSucceed) throw Exception("코스 선호 조사에 실패했습니다.");
      return Success(data: null);
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }

  @override
  Future<Result<void>> updateProfile({required ProfileUpdateRequest request}) async {
    // TODO: implement updateProfile
    return Failure(exception: Exception("Not implemented"));
  }
}
