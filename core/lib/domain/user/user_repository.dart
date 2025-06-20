import 'package:core/common/result.dart';
import 'package:core/domain/user/model/preference_update_requrest.dart';
import 'package:core/domain/user/model/profile_update_request.dart';
import 'package:core/domain/user/model/preference_question.dart';
import 'package:core/domain/user/model/user_entity.dart';

abstract interface class UserRepository {
  /// 사용자 정보
  Future<Result<UserEntity>> get user;

  /// 사용자 여정 취향 질문
  Future<Result<List<PreferenceQuestion>>> get preferenceQuestions;

  /// 사용자 정보 수정
  /// 
  /// 성공 여부를 반환한다.
  Future<Result<bool>> updateProfile({required ProfileUpdateRequest request});

  /// 사용자 여정 취향 수정
  /// 
  /// 성공 여부를 반환한다.
  Future<Result<bool>> updatePreference({required PreferenceUpdateRequest request});
}