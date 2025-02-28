import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../misc/colors.dart';
import '../../app/bloc/app_bloc.dart';
import '../cubit/forum_detail_cubit.dart';
import '../view/forum_detail_page.dart';

import '../../../misc/date_helper.dart';
import '../../../misc/injections.dart';
import '../../../repositories/forum_repository/models/forums_model.dart';
import '../../../widgets/detect_text/detect_text.dart';
import '../../../widgets/image/image_avatar.dart';

class CardReply extends StatefulWidget {
  const CardReply({super.key, this.comment, required this.focusNode});

  final Replies? comment;
  final FocusNode focusNode;

  @override
  State<CardReply> createState() => _CardReplyState();
}

class _CardReplyState extends State<CardReply> {
  @override
  Widget build(BuildContext context) {
    final userId = getIt<AppBloc>().state.user?.id;
    // final userId = getIt<AppBloc>().state.user?.id;
    final user = widget.comment?.user;
    return BlocBuilder<ForumDetailCubit, ForumDetailState>(
        builder: (context, state) {
      return Padding(
        key: GlobalObjectKey(widget.comment?.id ?? 0),
        padding: const EdgeInsets.only(bottom: 5, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {},
                      child: ImageAvatar(
                          image: state.detailForum?.user?.profile?.avatarLink ??
                              "",
                          radius: 18)),
                ),
                Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              color: widget.comment?.id == state.lastIdComment
                                  ? AppColors.secondaryColor
                                  : AppColors.greyColor.withOpacity(0.3)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      user?.profile == null
                                          ? user?.profile.fullname ?? ""
                                          : user?.profile.fullname ?? "",
                                      style: TextStyle(
                                          color: widget.comment?.id ==
                                                  state.lastIdComment
                                              ? AppColors.whiteColor
                                              : AppColors.blackColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                ],
                              ),
                              DetectText(
                                  text: widget.comment?.comment ?? "",
                                  colorText:
                                      widget.comment?.id == state.lastIdComment
                                          ? AppColors.whiteColor
                                          : AppColors.blackColor),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              DateHelper.getFormatedDateWithHours(
                                  widget.comment?.createdAt ??
                                      DateTime.now().toString()),
                              style: const TextStyle(
                                  color: AppColors.greyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  int commentId = 0;
                                  commentId = widget.comment?.commentId ?? 0;
                                  FocusScope.of(context)
                                      .requestFocus(widget.focusNode);
                                  SystemChannels.textInput
                                      .invokeMethod("TextInput.show");

                                  if ((widget.comment?.userId ?? 0) == userId) {
                                    commentKey.currentState!.controller!.text =
                                        "";
                                  } else {
                                    commentKey.currentState!.controller!.text =
                                        "@${user?.profile == null ? user?.profile.fullname ?? "" : user?.profile.fullname ?? ""} ";
                                  }

                                  var cubit = context.read<ForumDetailCubit>();
                                  cubit.copyState(
                                      newState: cubit.state.copyWith(
                                    commentId: commentId,
                                  ));
                                  print("Id Comment ${state.commentId}");
                                });
                              },
                              child: const Text(
                                "Balas",
                                style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
      );
    });
  }
}
