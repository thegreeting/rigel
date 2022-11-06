import 'package:freezed_annotation/freezed_annotation.dart';

part 'greeting_word.entity.freezed.dart';
part 'greeting_word.entity.g.dart';

@freezed
class GreetingWord with _$GreetingWord {
  const factory GreetingWord({
    // https://schema.org/Thing
    required String id,
    required String name,
    String? description,
  }) = _GreetingWord;
  const GreetingWord._();

  factory GreetingWord.fromJson(Map<String, dynamic> json) =>
      _$GreetingWordFromJson(json);

  int get index => int.parse(id);
}
