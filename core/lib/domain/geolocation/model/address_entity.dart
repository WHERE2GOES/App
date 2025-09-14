import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_entity.freezed.dart';

@freezed
abstract class AddressEntity with _$AddressEntity {
  const factory AddressEntity({
    required String city,
    required String full,
  }) = _AddressEntity;
}
