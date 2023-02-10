// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaign.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Campaign _$CampaignFromJson(Map<String, dynamic> json) {
  return _Campaign.fromJson(json);
}

/// @nodoc
mixin _$Campaign {
// https://schema.org/Thing
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get url =>
      throw _privateConstructorUsedError; // required ImageObject image, // representative image
// https://schema.org/CreativeWork
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate =>
      throw _privateConstructorUsedError; // https://schema.org/FinancialProduct
  String get currency => throw _privateConstructorUsedError;
  BigInt get pricePerMessage => throw _privateConstructorUsedError; // [Wei]
// ---
  List<GreetingWord> get greetingWords => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CampaignCopyWith<Campaign> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CampaignCopyWith<$Res> {
  factory $CampaignCopyWith(Campaign value, $Res Function(Campaign) then) =
      _$CampaignCopyWithImpl<$Res, Campaign>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String? url,
      DateTime startDate,
      DateTime endDate,
      String currency,
      BigInt pricePerMessage,
      List<GreetingWord> greetingWords});
}

/// @nodoc
class _$CampaignCopyWithImpl<$Res, $Val extends Campaign>
    implements $CampaignCopyWith<$Res> {
  _$CampaignCopyWithImpl(this._value, this._then);

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
    Object? url = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? currency = null,
    Object? pricePerMessage = null,
    Object? greetingWords = null,
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
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      pricePerMessage: null == pricePerMessage
          ? _value.pricePerMessage
          : pricePerMessage // ignore: cast_nullable_to_non_nullable
              as BigInt,
      greetingWords: null == greetingWords
          ? _value.greetingWords
          : greetingWords // ignore: cast_nullable_to_non_nullable
              as List<GreetingWord>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CampaignCopyWith<$Res> implements $CampaignCopyWith<$Res> {
  factory _$$_CampaignCopyWith(
          _$_Campaign value, $Res Function(_$_Campaign) then) =
      __$$_CampaignCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String? url,
      DateTime startDate,
      DateTime endDate,
      String currency,
      BigInt pricePerMessage,
      List<GreetingWord> greetingWords});
}

/// @nodoc
class __$$_CampaignCopyWithImpl<$Res>
    extends _$CampaignCopyWithImpl<$Res, _$_Campaign>
    implements _$$_CampaignCopyWith<$Res> {
  __$$_CampaignCopyWithImpl(
      _$_Campaign _value, $Res Function(_$_Campaign) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? url = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? currency = null,
    Object? pricePerMessage = null,
    Object? greetingWords = null,
  }) {
    return _then(_$_Campaign(
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
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      pricePerMessage: null == pricePerMessage
          ? _value.pricePerMessage
          : pricePerMessage // ignore: cast_nullable_to_non_nullable
              as BigInt,
      greetingWords: null == greetingWords
          ? _value._greetingWords
          : greetingWords // ignore: cast_nullable_to_non_nullable
              as List<GreetingWord>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Campaign implements _Campaign {
  const _$_Campaign(
      {required this.id,
      required this.name,
      this.description,
      this.url,
      required this.startDate,
      required this.endDate,
      required this.currency,
      required this.pricePerMessage,
      required final List<GreetingWord> greetingWords})
      : _greetingWords = greetingWords;

  factory _$_Campaign.fromJson(Map<String, dynamic> json) =>
      _$$_CampaignFromJson(json);

// https://schema.org/Thing
  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? url;
// required ImageObject image, // representative image
// https://schema.org/CreativeWork
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
// https://schema.org/FinancialProduct
  @override
  final String currency;
  @override
  final BigInt pricePerMessage;
// [Wei]
// ---
  final List<GreetingWord> _greetingWords;
// [Wei]
// ---
  @override
  List<GreetingWord> get greetingWords {
    if (_greetingWords is EqualUnmodifiableListView) return _greetingWords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_greetingWords);
  }

  @override
  String toString() {
    return 'Campaign(id: $id, name: $name, description: $description, url: $url, startDate: $startDate, endDate: $endDate, currency: $currency, pricePerMessage: $pricePerMessage, greetingWords: $greetingWords)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Campaign &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.pricePerMessage, pricePerMessage) ||
                other.pricePerMessage == pricePerMessage) &&
            const DeepCollectionEquality()
                .equals(other._greetingWords, _greetingWords));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      url,
      startDate,
      endDate,
      currency,
      pricePerMessage,
      const DeepCollectionEquality().hash(_greetingWords));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CampaignCopyWith<_$_Campaign> get copyWith =>
      __$$_CampaignCopyWithImpl<_$_Campaign>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CampaignToJson(
      this,
    );
  }
}

abstract class _Campaign implements Campaign {
  const factory _Campaign(
      {required final String id,
      required final String name,
      final String? description,
      final String? url,
      required final DateTime startDate,
      required final DateTime endDate,
      required final String currency,
      required final BigInt pricePerMessage,
      required final List<GreetingWord> greetingWords}) = _$_Campaign;

  factory _Campaign.fromJson(Map<String, dynamic> json) = _$_Campaign.fromJson;

  @override // https://schema.org/Thing
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get url;
  @override // required ImageObject image, // representative image
// https://schema.org/CreativeWork
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override // https://schema.org/FinancialProduct
  String get currency;
  @override
  BigInt get pricePerMessage;
  @override // [Wei]
// ---
  List<GreetingWord> get greetingWords;
  @override
  @JsonKey(ignore: true)
  _$$_CampaignCopyWith<_$_Campaign> get copyWith =>
      throw _privateConstructorUsedError;
}
