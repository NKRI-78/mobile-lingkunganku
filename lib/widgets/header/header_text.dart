import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../misc/colors.dart';
import '../../misc/text_style.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      surfaceTintColor: Colors.transparent,
      pinned: true,
      toolbarHeight: 80,
      elevation: 2,
      title: Text(text, style: AppTextStyles.textStyle1.copyWith(fontSize: 20)),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          GoRouter.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }
}
