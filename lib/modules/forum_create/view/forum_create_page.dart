import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/misc/text_style.dart';
import 'package:mobile_lingkunganku/modules/forum/cubit/forum_cubit.dart';
import 'package:mobile_lingkunganku/modules/forum_create/cubit/forum_create_cubit.dart';
import 'package:mobile_lingkunganku/modules/forum_create/widget/_button_media.dart';
import 'package:mobile_lingkunganku/modules/forum_create/widget/_thumbnail_media.dart';
import 'package:mobile_lingkunganku/widgets/button/custom_button.dart';

import '../../../misc/snackbar.dart';

part '../widget/_input_description.dart';

class ForumCreatePage extends StatelessWidget {
  const ForumCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForumCreateCubit(),
      child: ForumCreateView(),
    );
  }
}

class ForumCreateView extends StatelessWidget {
  const ForumCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomButton(
                  text: 'Posting',
                  onPressed: () async {
                    await context.read<ForumCreateCubit>().createForum(context);
                    if (context.mounted) {
                      Navigator.pop(context);
                      getIt<ForumCubit>().fetchForum();
                      ShowSnackbar.snackbar(context, "Berhasil membuat Forum",
                          "", AppColors.secondaryColor);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 80,
            title: Text(
              'Create Forum',
              style: AppTextStyles.textStyle1,
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.buttonColor2,
                size: 32,
              ),
              onPressed: () {
                GoRouter.of(context).pop();
              },
            ),
          ),
          SliverList.list(
            children: [
              InputDescription(),
              SizedBox(height: 20),
              ButtonMedia(),
              ThumbnailMedia()
            ],
          )
        ],
      ),
    );
  }
}
