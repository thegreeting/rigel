// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_object.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ImageObject _$ImageObjectFromJson(Map<String, dynamic> json) {
  return _ImageObject.fromJson(json);
}

/// @nodoc
mixin _$ImageObject {
// https://schema.org/Thing
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get image =>
      throw _privateConstructorUsedError; // https://schema.org/CreativeWork
  Person? get author =>
      throw _privateConstructorUsedError; // https://schema.org/MediaObject
  String get contentUrl => throw _privateConstructorUsedError;
  int get width => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;
  DateTime? get uploadDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImageObjectCopyWith<ImageObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageObjectCopyWith<$Res> {
  factory $ImageObjectCopyWith(
          ImageObject value, $Res Function(ImageObject) then) =
      _$ImageObjectCopyWithImpl<$Res, ImageObject>;
  @useResult
  $Res call(
      {String id,
      String? name,
      String? description,
      String? url,
      String? image,
      Person? author,
      String contentUrl,
      int width,
      int height,
      DateTime? uploadDate});

  $PersonCopyWith<$Res>? get author;
}

/// @nodoc
class _$ImageObjectCopyWithImpl<$Res, $Val extends ImageObject>
    implements $ImageObjectCopyWith<$Res> {
  _$ImageObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? description = freezed,
    Object? url = freezed,
    Object? image = freezed,
    Object? author = freezed,
    Object? contentUrl = null,
    Object? width = null,
    Object? height = null,
    Object? uploadDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
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
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Person?,
      contentUrl: null == contentUrl
          ? _value.contentUrl
          : contentUrl // ignore: cast_nullable_to_non_nullable
              as String,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      uploadDate: freezed == uploadDate
          ? _value.uploadDate
          : uploadDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PersonCopyWith<$Res>? get author {
    if (_value.author == null) {
      return null;
    }

    return $PersonCopyWith<$Res>(_value.author!, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ImageObjectCopyWith<$Res>
    implements $ImageObjectCopyWith<$Res> {
  factory _$$_ImageObjectCopyWith(
          _$_ImageObject value, $Res Function(_$_ImageObject) then) =
      __$$_ImageObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? name,
      String? description,
      String? url,
      String? image,
      Person? author,
      String contentUrl,
      int width,
      int height,
      DateTime? uploadDate});

  @override
  $PersonCopyWith<$Res>? get author;
}

/// @nodoc
class __$$_ImageObjectCopyWithImpl<$Res>
    extends _$ImageObjectCopyWithImpl<$Res, _$_ImageObject>
    implements _$$_ImageObjectCopyWith<$Res> {
  __$$_ImageObjectCopyWithImpl(
      _$_ImageObject _value, $Res Function(_$_ImageObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? description = freezed,
    Object? url = freezed,
    Object? image = freezed,
    Object? author = freezed,
    Object? contentUrl = null,
    Object? width = null,
    Object? height = null,
    Object? uploadDate = freezed,
  }) {
    return _then(_$_ImageObject(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
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
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Person?,
      contentUrl: null == contentUrl
          ? _value.contentUrl
          : contentUrl // ignore: cast_nullable_to_non_nullable
              as String,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      uploadDate: freezed == uploadDate
          ? _value.uploadDate
          : uploadDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ImageObject extends _ImageObject {
  const _$_ImageObject(
      {required this.id,
      this.name,
      this.description,
      this.url,
      this.image,
      this.author,
      required this.contentUrl,
      required this.width,
      required this.height,
      this.uploadDate})
      : super._();

  factory _$_ImageObject.fromJson(Map<String, dynamic> json) =>
      _$$_ImageObjectFromJson(json);

// https://schema.org/Thing
  @override
  final String id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? url;
  @override
  final String? image;
// https://schema.org/CreativeWork
  @override
  final Person? author;
// https://schema.org/MediaObject
  @override
  final String contentUrl;
  @override
  final int width;
  @override
  final int height;
  @override
  final DateTime? uploadDate;

  @override
  String toString() {
    return 'ImageObject(id: $id, name: $name, description: $description, url: $url, image: $image, author: $author, contentUrl: $contentUrl, width: $width, height: $height, uploadDate: $uploadDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImageObject &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.contentUrl, contentUrl) ||
                other.contentUrl == contentUrl) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.uploadDate, uploadDate) ||
                other.uploadDate == uploadDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, url,
      image, author, contentUrl, width, height, uploadDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ImageObjectCopyWith<_$_ImageObject> get copyWith =>
      __$$_ImageObjectCopyWithImpl<_$_ImageObject>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ImageObjectToJson(
      this,
    );
  }
}

abstract class _ImageObject extends ImageObject {
  const factory _ImageObject(
      {required final String id,
      final String? name,
      final String? description,
      final String? url,
      final String? image,
      final Person? author,
      required final String contentUrl,
      required final int width,
      required final int height,
      final DateTime? uploadDate}) = _$_ImageObject;
  const _ImageObject._() : super._();

  factory _ImageObject.fromJson(Map<String, dynamic> json) =
      _$_ImageObject.fromJson;

  @override // https://schema.org/Thing
  String get id;
  @override
  String? get name;
  @override
  String? get description;
  @override
  String? get url;
  @override
  String? get image;
  @override // https://schema.org/CreativeWork
  Person? get author;
  @override // https://schema.org/MediaObject
  String get contentUrl;
  @override
  int get width;
  @override
  int get height;
  @override
  DateTime? get uploadDate;
  @override
  @JsonKey(ignore: true)
  _$$_ImageObjectCopyWith<_$_ImageObject> get copyWith =>
      throw _privateConstructorUsedError;
}
