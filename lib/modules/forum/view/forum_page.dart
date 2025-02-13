import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/misc/text_style.dart';
import 'package:mobile_lingkunganku/modules/forum/cubit/forum_cubit.dart';
import 'package:mobile_lingkunganku/modules/forum/widget/forum_input_section.dart';
import 'package:mobile_lingkunganku/modules/forum/widget/forum_post_item_section.dart';
import '../../../widgets/extension/date_util.dart';

class ForumPage extends StatelessWidget {
  const ForumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ForumCubit>()..fetchForum(),
      child: const ForumView(),
    );
  }
}

class ForumView extends StatelessWidget {
  const ForumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forum",
          style: AppTextStyles.textStyle1,
        ),
        centerTitle: true,
        toolbarHeight: 100,
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
        elevation: 0,
      ),
      body: Column(
        spacing: 10,
        children: [
          const ForumInput(),
          Expanded(
            child: BlocBuilder<ForumCubit, ForumState>(
              builder: (context, state) {
                if (state.loading && state.forums.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.forums.isEmpty) {
                  return const Center(
                      child: Text("Tidak ada postingan forum."));
                }

                return RefreshIndicator(
                  onRefresh: () async =>
                      context.read<ForumCubit>().fetchForum(),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: state.forums.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final forum = state.forums[index];

                      return ForumPostItem(
                        avatarUrl: forum.user.profile.avatarLink,
                        username: forum.user.profile.fullname,
                        timeAgo: DateUntil.formatDate(forum.createdAt),
                        content: forum.description,
                        images: forum.media.map((media) => media.link).toList(),
                        likes: forum.id,
                        answers: forum.comment.length,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
