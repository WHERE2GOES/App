import 'package:freezed_annotation/freezed_annotation.dart';

part 'preference_question_entity.freezed.dart';

@freezed
abstract class PreferenceQuestionEntity with _$PreferenceQuestionEntity {
  const factory PreferenceQuestionEntity({
    required int id,
    required String question,
    required List<String> options,
  }) = _PreferenceQuestionEntity;
}
