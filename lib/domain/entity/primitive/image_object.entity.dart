import 'package:freezed_annotation/freezed_annotation.dart';

import 'person.entity.dart';

part 'image_object.entity.freezed.dart';
part 'image_object.entity.g.dart';

// https://schema.org/ImageObject

@freezed
class ImageObject with _$ImageObject {
  const factory ImageObject({
    // https://schema.org/Thing
    required String id,
    String? name,
    String? description,
    String? url,
    String? image,
    // https://schema.org/CreativeWork
    Person? author,
    // https://schema.org/MediaObject
    required String contentUrl,
    required int width,
    required int height,
    DateTime? uploadDate,
    // https://schema.org/ImageObject
    // required ThumbnailImageObject thumbnail,
  }) = _ImageObject;

  factory ImageObject.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ImageObjectFromJson(json);

  const ImageObject._();
  factory ImageObject.dummy({
    required String id,
  }) =>
      ImageObject(
        id: id,
        contentUrl:
            'https://placehold.jp/fff/512x512.png?text=NoImage&css=%7B%22font-weight%22%3A%22%20bold%22%2C%22background%22%3A%22%20-webkit-gradient(linear%2C%20left%20top%2C%20right%20bottom%2C%20from(%2377bb41)%2C%20to(%23ebf38f))%22%7D',
        width: 512,
        height: 512,
      );

  double get aspectRatio => width / height;
  bool get isRemote => contentUrl.startsWith('http');
}
