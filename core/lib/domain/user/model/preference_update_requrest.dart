import 'package:freezed_annotation/freezed_annotation.dart';

part 'preference_update_requrest.freezed.dart';

@freezed
abstract class PreferenceUpdateRequest with _$PreferenceUpdateRequest {
  const factory PreferenceUpdateRequest({
    required Iterable<({int questionId, int selectedOptionIndex})> preferences,
  }) = _PreferenceUpdateRequest;
}
