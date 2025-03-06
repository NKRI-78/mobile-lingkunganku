import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/misc/text_style.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(text, style: AppTextStyles.textStyle1),
      centerTitle: true,
      leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.secondaryColor,
          )),
    );
  }
}
