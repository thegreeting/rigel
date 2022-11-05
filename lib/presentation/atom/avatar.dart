import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../domain/entity/account/wallet_account.entity.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    this.size,
    this.isAnonymous = false,
    this.backgroundColor,
    this.backgroundImage,
    this.name,
    this.onTap,
    this.alignment,
  });

  const Avatar.anonymous({
    super.key,
    this.size,
    this.onTap,
    this.alignment,
  })  : backgroundColor = const Color.fromARGB(255, 175, 175, 175),
        backgroundImage = null,
        isAnonymous = true,
        name = 'Anonymous';

  factory Avatar.fromWalletAccount(
    WalletAccount? e, {
    double? size,
    VoidCallback? onTap,
    Alignment? alignment,
  }) {
    if (e == null) {
      return const Avatar.anonymous();
    }
    return Avatar(
      size: size,
      backgroundColor: const Color(0xffffffff),
      backgroundImage: e.image != null ? CachedNetworkImageProvider(e.image!) : null,
      name: e.nameForAvatar ?? e.name,
      onTap: onTap,
      alignment: alignment,
    );
  }

  final bool isAnonymous;
  final Color? backgroundColor;
  final ImageProvider? backgroundImage;
  final double? size;
  final String? name;
  final VoidCallback? onTap;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    final avatarSize = size ?? 24;
    final child = isAnonymous
        ? CircleAvatar(
            radius: avatarSize,
            backgroundColor: backgroundColor,
            child: Icon(
              PlatformIcons(context).personSolid,
              color: const Color.fromARGB(255, 110, 110, 110),
            ),
          )
        : CircleAvatar(
            radius: avatarSize,
            backgroundColor: backgroundColor,
            backgroundImage: backgroundImage,
            child: (backgroundImage == null && name != null)
                ? Text(
                    name!.substring(0, 1),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                : null,
          );

    if (onTap != null) {
      return PlatformIconButton(
        onPressed: onTap,
        padding: EdgeInsets.zero,
        icon: child,
        cupertino: (_, __) => CupertinoIconButtonData(
          alignment: alignment,
        ),
      );
    } else {
      return child;
    }
  }
}
