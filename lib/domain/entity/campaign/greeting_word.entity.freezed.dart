// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'greeting_word.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GreetingWord _$GreetingWordFromJson(Map<String, dynamic> json) {
  return _GreetingWord.fromJson(json);
}

/// @nodoc
mixin _$GreetingWord {
// https://schema.org/Thing
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GreetingWordCopyWith<GreetingWord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GreetingWordCopyWith<$Res> {
  factory $GreetingWordCopyWith(
          GreetingWord value, $Res Function(GreetingWord) then) =
      _$GreetingWordCopyWithImpl<$Res, GreetingWord>;
  @useResult
  $Res call({String id, String name, String? description});
}

/// @nodoc
class _$GreetingWordCopyWithImpl<$Res, $Val extends GreetingWord>
    implements $GreetingWordCopyWith<$Res> {
  _$GreetingWordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GreetingWordCopyWith<$Res>
    implements $GreetingWordCopyWith<$Res> {
  factory _$$_GreetingWordCopyWith(
          _$_GreetingWord value, $Res Function(_$_GreetingWord) then) =
      __$$_GreetingWordCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String? description});
}

/// @nodoc
class __$$_GreetingWordCopyWithImpl<$Res>
    extends _$GreetingWordCopyWithImpl<$Res, _$_GreetingWord>
    implements _$$_GreetingWordCopyWith<$Res> {
  __$$_GreetingWordCopyWithImpl(
      _$_GreetingWord _value, $Res Function(_$_GreetingWord) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
  }) {
    return _then(_$_GreetingWord(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GreetingWord implements _GreetingWord {
  const _$_GreetingWord(
      {required this.id, required this.name, this.description});

  factory _$_GreetingWord.fromJson(Map<String, dynamic> json) =>
      _$$_GreetingWordFromJson(json);

// https://schema.org/Thing
  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;

  @override
  String toString() {
    return 'GreetingWord(id: $id, name: $name, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GreetingWord &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GreetingWordCopyWith<_$_GreetingWord> get copyWith =>
      __$$_GreetingWordCopyWithImpl<_$_GreetingWord>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GreetingWordToJson(
      this,
    );
  }
}

abstract class _GreetingWord implements GreetingWord {
  const factory _GreetingWord(
      {required final String id,
      required final String name,
      final String? description}) = _$_GreetingWord;

  factory _GreetingWord.fromJson(Map<String, dynamic> json) =
      _$_GreetingWord.fromJson;

  @override // https://schema.org/Thing
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$_GreetingWordCopyWith<_$_GreetingWord> get copyWith =>
      throw _privateConstructorUsedError;
}
