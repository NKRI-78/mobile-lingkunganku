part of '../view/forum_detail_page.dart';

GlobalKey<FlutterMentionsState> commentKey = GlobalKey<FlutterMentionsState>();

class InputComment extends StatelessWidget {
  const InputComment({
    super.key,
    required this.idForum,
    required this.gk,
    required this.inputNode,
  });

  final int idForum;
  final GlobalKey gk;
  final FocusNode inputNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForumDetailCubit, ForumDetailState>(
      builder: (context, state) {
        return Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: AppColors.greyColor.withValues(alpha: 0.3),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImageAvatar(
                          image: state.profile?.profile?.avatarLink ?? '',
                          radius: 20),
                      const SizedBox(width: 15.0),
                      Expanded(
                          child: FlutterMentions(
                        key: commentKey,
                        suggestionPosition: SuggestionPosition.Top,
                        appendSpaceOnAdd: true,
                        cursorColor: AppColors.whiteColor,
                        focusNode: inputNode,
                        maxLines: 5,
                        minLines: 1,
                        onChanged: (value) {
                          var cubit = context.read<ForumDetailCubit>();
                          cubit.copyState(
                              newState:
                                  cubit.state.copyWith(inputComment: value));
                        },
                        style: const TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 14,
                        ),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 16.0),
                            fillColor: AppColors.greyColor,
                            filled: true,
                            hintText: "Tulis komentar...",
                            hintStyle: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide(
                                    width: 1.0, color: AppColors.greyColor)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide(
                                    width: 1.0, color: AppColors.greyColor)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide(
                                    width: 1.0, color: AppColors.greyColor)),
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide(
                                    width: 1.0, color: AppColors.greyColor))),
                        mentions: [Mention(trigger: "#")],
                      )),
                      const SizedBox(width: 15.0),
                      IconButton(
                          onPressed: state.loadingComment ||
                                  state.detailForum == null
                              ? null
                              : () async {
                                  if (commentKey.currentState!.controller!.text
                                          .trim() ==
                                      "") {
                                    commentKey.currentState!.controller!.text =
                                        "";
                                    var cubit =
                                        context.read<ForumDetailCubit>();
                                    cubit.copyState(
                                        newState: cubit.state
                                            .copyWith(inputComment: ""));
                                    return;
                                  } else {
                                    await context
                                        .read<ForumDetailCubit>()
                                        .createComment(
                                            context, idForum.toString(), gk);
                                    commentKey.currentState!.controller!.text =
                                        "";
                                    // ignore: use_build_context_synchronously
                                    var cubit =
                                        context.read<ForumDetailCubit>();
                                    cubit.copyState(
                                        newState: cubit.state
                                            .copyWith(inputComment: ""));
                                    if (context.mounted) {
                                      FocusScope.of(context).unfocus();
                                    }
                                  }
                                },
                          icon: Icon(
                            Icons.send,
                            color: state.loadingComment ||
                                    state.detailForum == null
                                ? AppColors.greyColor
                                : AppColors.greyColor,
                          ))
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }
}
