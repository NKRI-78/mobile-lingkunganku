import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../misc/text_style.dart';
import '../../../widgets/button/custom_button.dart';
import '../../forum/cubit/forum_cubit.dart';
import '../cubit/forum_create_cubit.dart';
import '../widget/_button_media.dart';
import '../widget/_thumbnail_media.dart';

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
      backgroundColor: AppColors.whiteColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
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
            size: 24,
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
      bottomNavigationBar: AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom > 0
              ? MediaQuery.of(context).viewInsets.bottom
              : 20,
          left: 20,
          right: 20,
        ),
        child: SafeArea(
          top: false,
          child: BlocBuilder<ForumCreateCubit, ForumCreateState>(
            builder: (context, state) {
              return CustomButton(
                text: state.loading ? 'Loading...' : 'Posting',
                onPressed: state.loading
                    ? null
                    : () async {
                        await context
                            .read<ForumCreateCubit>()
                            .createForum(context);

                        if (context.mounted &&
                            context
                                .read<ForumCreateCubit>()
                                .state
                                .description
                                .trim()
                                .isNotEmpty) {
                          getIt<ForumCubit>().fetchForum();
                          Navigator.pop(context);
                        }
                      },
                child: state.loading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : null,
              );
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            InputDescription(),
            SizedBox(height: 15),
            ButtonMedia(),
            SizedBox(height: 10),
            ThumbnailMedia(),
          ],
        ),
      ),
    );
  }
}
