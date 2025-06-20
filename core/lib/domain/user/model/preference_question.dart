import 'package:freezed_annotation/freezed_annotation.dart';

part 'preference_question.freezed.dart';

@freezed
abstract class PreferenceQuestion with _$PreferenceQuestion {
  const factory PreferenceQuestion({
    required int id,
    required String question,
    required List<String> options,
  }) = _PreferenceQuestion;
}
