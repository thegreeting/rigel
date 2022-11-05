// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wallet_account.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WalletAccount _$WalletAccountFromJson(Map<String, dynamic> json) {
  return _WalletAccount.fromJson(json);
}

/// @nodoc
mixin _$WalletAccount {
// https://schema.org/Thing
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError; // --
  String? get nameForAvatar => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WalletAccountCopyWith<WalletAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletAccountCopyWith<$Res> {
  factory $WalletAccountCopyWith(
          WalletAccount value, $Res Function(WalletAccount) then) =
      _$WalletAccountCopyWithImpl<$Res, WalletAccount>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String? url,
      String? image,
      String? nameForAvatar});
}

/// @nodoc
class _$WalletAccountCopyWithImpl<$Res, $Val extends WalletAccount>
    implements $WalletAccountCopyWith<$Res> {
  _$WalletAccountCopyWithImpl(this._value, this._then);

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
    Object? image = freezed,
    Object? nameForAvatar = freezed,
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
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      nameForAvatar: freezed == nameForAvatar
          ? _value.nameForAvatar
          : nameForAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WalletAccountCopyWith<$Res>
    implements $WalletAccountCopyWith<$Res> {
  factory _$$_WalletAccountCopyWith(
          _$_WalletAccount value, $Res Function(_$_WalletAccount) then) =
      __$$_WalletAccountCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String? url,
      String? image,
      String? nameForAvatar});
}

/// @nodoc
class __$$_WalletAccountCopyWithImpl<$Res>
    extends _$WalletAccountCopyWithImpl<$Res, _$_WalletAccount>
    implements _$$_WalletAccountCopyWith<$Res> {
  __$$_WalletAccountCopyWithImpl(
      _$_WalletAccount _value, $Res Function(_$_WalletAccount) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? url = freezed,
    Object? image = freezed,
    Object? nameForAvatar = freezed,
  }) {
    return _then(_$_WalletAccount(
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
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      nameForAvatar: freezed == nameForAvatar
          ? _value.nameForAvatar
          : nameForAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WalletAccount extends _WalletAccount {
  const _$_WalletAccount(
      {required this.id,
      required this.name,
      this.description,
      this.url,
      this.image,
      this.nameForAvatar})
      : super._();

  factory _$_WalletAccount.fromJson(Map<String, dynamic> json) =>
      _$$_WalletAccountFromJson(json);

// https://schema.org/Thing
  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? url;
  @override
  final String? image;
// --
  @override
  final String? nameForAvatar;

  @override
  String toString() {
    return 'WalletAccount(id: $id, name: $name, description: $description, url: $url, image: $image, nameForAvatar: $nameForAvatar)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WalletAccount &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.nameForAvatar, nameForAvatar) ||
                other.nameForAvatar == nameForAvatar));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, description, url, image, nameForAvatar);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WalletAccountCopyWith<_$_WalletAccount> get copyWith =>
      __$$_WalletAccountCopyWithImpl<_$_WalletAccount>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WalletAccountToJson(
      this,
    );
  }
}

abstract class _WalletAccount extends WalletAccount {
  const factory _WalletAccount(
      {required final String id,
      required final String name,
      final String? description,
      final String? url,
      final String? image,
      final String? nameForAvatar}) = _$_WalletAccount;
  const _WalletAccount._() : super._();

  factory _WalletAccount.fromJson(Map<String, dynamic> json) =
      _$_WalletAccount.fromJson;

  @override // https://schema.org/Thing
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get url;
  @override
  String? get image;
  @override // --
  String? get nameForAvatar;
  @override
  @JsonKey(ignore: true)
  _$$_WalletAccountCopyWith<_$_WalletAccount> get copyWith =>
      throw _privateConstructorUsedError;
}
