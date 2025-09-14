import 'package:freezed_annotation/freezed_annotation.dart';

part 'certificate_entity.freezed.dart';

@freezed
abstract class CertificateEntity with _$CertificateEntity {
  const factory CertificateEntity({
    required int id,
    required String name,
    required bool isCompleted,
  }) = _CertificateEntity;
}
