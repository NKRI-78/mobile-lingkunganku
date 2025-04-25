import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../misc/theme.dart';

class ImageAvatar extends StatelessWidget {
  final String image;
  final double radius;
  const ImageAvatar({super.key, required this.image, required this.radius});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder:
          (BuildContext context, ImageProvider<Object> imageProvider) {
        return CircleAvatar(
          radius: radius,
          backgroundImage: imageProvider,
        );
      },
      placeholder: (BuildContext context, String url) {
        return CircleAvatar(
          radius: radius,
          backgroundColor: const Color(0xFF637687),
        );
      },
      errorWidget: (BuildContext context, String url, dynamic error) {
        return CircleAvatar(
          radius: radius,
          backgroundImage: const AssetImage(avatarDefault),
        );
      },
    );
  }
}
