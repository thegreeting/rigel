// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type, unnecessary_cast, mixin_inherits_from_not_object

part of 'image_object.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ImageObject _$$_ImageObjectFromJson(Map<String, dynamic> json) =>
    _$_ImageObject(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      image: json['image'] as String?,
      author: json['author'] == null
          ? null
          : Person.fromJson(json['author'] as Map<String, dynamic>),
      contentUrl: json['content_url'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
      uploadDate: json['upload_date'] == null
          ? null
          : DateTime.parse(json['upload_date'] as String),
    );

Map<String, dynamic> _$$_ImageObjectToJson(_$_ImageObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'image': instance.image,
      'author': instance.author,
      'content_url': instance.contentUrl,
      'width': instance.width,
      'height': instance.height,
      'upload_date': instance.uploadDate?.toIso8601String(),
    };
