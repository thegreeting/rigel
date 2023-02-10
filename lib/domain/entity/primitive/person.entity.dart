import 'package:freezed_annotation/freezed_annotation.dart';

part 'person.entity.freezed.dart';
part 'person.entity.g.dart';

// https://schema.org/Person

@freezed
class Person with _$Person {
  const factory Person({
    // https://schema.org/Thing
    required String id,
    required String name,
    String? description,
    String? url,
    String? image,
    // --
    String? nameForAvatar,
  }) = _Person;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
