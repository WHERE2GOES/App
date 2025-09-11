import 'package:core/common/result.dart';
import 'package:core/domain/user/model/course_preference_type.dart';
import 'package:core/domain/user/model/preference_update_requrest.dart';
import 'package:core/domain/user/model/profile_update_request.dart';
import 'package:core/domain/user/model/preference_question_entity.dart';
import 'package:core/domain/user/model/sign_up_request.dart';
import 'package:core/domain/user/model/user_entity.dart';

abstract interface class UserRepository {
  /// 사용자 정보
  Future<Result<UserEntity>> getUserInfo();

  /// 사용자 여정 취향 질문 리스트
  Future<Result<List<PreferenceQuestionEntity>>> getPreferenceQuestions();

  /// 사용자 여정 취향
  Future<Result<CoursePreferenceType>> getCoursePreferenceType();

  /// 사용자 가입 절차 수행
  Future<Result<void>> signUp({required SignUpRequest request});

  /// 사용자 정보 수정
  ///
  /// 성공 여부를 반환한다.
  Future<Result<void>> updateProfile({required ProfileUpdateRequest request});

  /// 사용자 여정 취향 수정
  ///
  /// 사용자 여정 취향 질문에 대한 답을 요청으로 받는다.
  /// 성공 여부를 반환한다.
  Future<Result<void>> updatePreference({
    required PreferenceUpdateRequest request,
  });
}
