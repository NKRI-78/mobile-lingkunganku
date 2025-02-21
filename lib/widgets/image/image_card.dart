import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../misc/colors.dart';
import 'package:shimmer/shimmer.dart';

class ImageCard extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final double radius;
  const ImageCard(
      {super.key,
      required this.image,
      required this.height,
      required this.radius,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      imageUrl: image,
      height: height,
      fit: BoxFit.cover,
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
        return Container(
          decoration: const BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Image.asset(
            "assets/images/no_image.png",
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
