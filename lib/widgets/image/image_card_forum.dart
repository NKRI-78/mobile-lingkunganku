import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../misc/colors.dart';
import '../../misc/theme.dart';

class ImageCardForum extends StatelessWidget {
  final String image;
  final double width;
  final double? height;
  final double radius;
  const ImageCardForum(
      {super.key,
      required this.image,
      required this.radius,
      required this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: image,
      fit: BoxFit.cover,
      placeholder: (BuildContext context, String val) {
        return SizedBox(
          width: width,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[200]!,
            child: Card(
              margin: EdgeInsets.zero,
              color: AppColors.whiteColor,
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
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
        return Container(
          decoration: const BoxDecoration(
              color: AppColors.redColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Image.asset(
            imageDefault,
            width: width,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
