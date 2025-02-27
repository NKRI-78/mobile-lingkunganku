import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/modules/app/bloc/app_bloc.dart';
import 'package:mobile_lingkunganku/modules/forum_detail/cubit/forum_detail_cubit.dart';
import 'package:mobile_lingkunganku/modules/forum_detail/widget/detail_card_header/detail_card_header_forum.dart';
import 'package:mobile_lingkunganku/modules/forum_detail/widget/media/media_images.dart';
import 'package:mobile_lingkunganku/repositories/forum_repository/models/forum_detail_model.dart';
import 'package:mobile_lingkunganku/router/builder.dart';

import 'package:mobile_lingkunganku/widgets/detect_text/detect_text.dart';
import 'package:mobile_lingkunganku/widgets/image/image_avatar.dart';
import 'package:mobile_lingkunganku/widgets/like/like_comment.dart';
import 'package:mobile_lingkunganku/widgets/like/like_comment_top.dart';
import 'package:mobile_lingkunganku/widgets/pages/page_empty.dart';
import 'package:mobile_lingkunganku/widgets/pages/pages_loading.dart';

import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:mobile_lingkunganku/widgets/pages/video/video_player.dart';

import '../../../misc/colors.dart';
import '../../../misc/modal.dart';
import '../../../misc/text_style.dart';
import '../widget/comment_forum.dart';

part '../widget/detail_forum.dart';
part '../widget/_input_comment.dart';

final GlobalKey dataKey = GlobalKey();

class ForumDetailPage extends StatelessWidget {
  const ForumDetailPage({super.key, required this.idForum});

  final String idForum;

  @override
  Widget build(BuildContext context) {
    return Portal(
      child: BlocProvider(
        create: (context) => ForumDetailCubit()..fetchForumDetail(idForum),
        child: ForumDetailView(),
      ),
    );
  }
}

class ForumDetailView extends StatefulWidget {
  const ForumDetailView({super.key});

  @override
  State<ForumDetailView> createState() => _ForumDetailViewState();
}

class _ForumDetailViewState extends State<ForumDetailView> {
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForumDetailCubit, ForumDetailState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Detail Forum", style: AppTextStyles.textStyle1),
            centerTitle: true,
            toolbarHeight: 80,
            elevation: 0,
            surfaceTintColor: Colors.white,
            backgroundColor: AppColors.whiteColor,
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
          bottomNavigationBar: InputComment(
            idForum: state.detailForum?.id ?? 0,
            gk: dataKey,
            inputNode: myFocusNode,
          ),
          body: CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: [
              state.loading
                  ? const SliverFillRemaining(
                      child: Center(child: LoadingPage()),
                    )
                  : state.detailForum == null
                      ? const SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: EmptyPage(
                              msg: "Tidak ada postingan",
                              noImage: true,
                              height: 0.50,
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Flexible(
                                child: DetailForum(
                                  focusNode: myFocusNode,
                                  forum: state.detailForum,
                                ),
                              )
                            ],
                          ),
                        )
            ],
          ),
        );
      },
    );
  }
}
