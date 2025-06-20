import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_cource_entity.freezed.dart';

@freezed
abstract class CurrentCourceEntity with _$CurrentCourceEntity {
  const factory CurrentCourceEntity({
    required int id,
    required String name,
  }) = _CurrentCourceEntity;
}