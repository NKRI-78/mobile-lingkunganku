import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../misc/colors.dart';

class ImageCard extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final double radius;
  final BoxFit? fit;
  final String imageError;
  const ImageCard(
      {super.key,
      required this.image,
      required this.height,
      required this.radius,
      required this.width,
      this.fit = BoxFit.fill,
      required this.imageError});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        width: width,
        imageUrl: image,
        height: height,
        fit: fit,
        placeholder: (BuildContext context, String val) {
          return SizedBox(
            width: width,
            height: height,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[200]!,
              child: Card(
                margin: EdgeInsets.zero,
                color: AppColors.whiteColor,
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      color: AppColors.whiteColor),
                ),
              ),
            ),
          );
        },
        errorWidget: (BuildContext context, String text, dynamic _) {
          return Image.asset(
            imageError,
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
