import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../domain/entity/primitive/image_object.entity.dart';

class SingleImage extends StatelessWidget {
  const SingleImage(
    this.image, {
    super.key,
    this.fit = BoxFit.cover,
    this.useThumbnail = false,
    this.width,
    this.height,
  });

  const SingleImage.square(
    this.image, {
    super.key,
    required double dimension,
  })  : fit = BoxFit.cover,
        useThumbnail = true,
        width = dimension,
        height = dimension;

  const SingleImage.expand(
    this.image, {
    super.key,
    this.fit = BoxFit.cover,
    this.useThumbnail = false,
    this.width = double.infinity,
    this.height = double.infinity,
  });

  final ImageObject image;
  final BoxFit fit;
  final bool useThumbnail;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    // TODO(knaoe): support thumbnail
    final url = image.contentUrl;
    if (image.isRemote) {
      return CachedNetworkImage(
        imageUrl: url,
        errorWidget: (context, url, dynamic error) =>
            Icon(PlatformIcons(context).error),
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      return Image.file(
        File(url),
        fit: fit,
        width: width,
        height: height,
      );
    }
  }
}
