part of '../view/forum_detail_page.dart';

class DetailForum extends StatelessWidget {
  const DetailForum({super.key, this.forum, required this.focusNode});

  final ForumDetailModel? forum;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      color: AppColors.whiteColor,
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailCardHeaderForum(
              forum: forum,
              onSelected: (value) {
                debugPrint("Value is : $value");
                if (value == "/delete") {
                  GeneralModal.showConfirmModal(
                      msg: "anda yakin ingin menghapusnya ?",
                      context: context,
                      onPressed: () async {
                        context.read<ForumDetailCubit>().deleteForum(
                              idForum: forum?.id.toString() ?? "0",
                              context: context,
                            );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Postingan berhasil dihapus!'),
                            backgroundColor: AppColors.secondaryColor,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      locationImage: 'assets/icons/delete-icon.png');
                } else {
                  GeneralModal.showConfirmModal(
                      msg: "anda yakin ingin melaporkannya ?",
                      context: context,
                      onPressed: () async {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Postingan berhasil dilaporkan!'),
                            backgroundColor: AppColors.secondaryColor,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      locationImage: 'assets/icons/delete-icon.png');
                }
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: DetectText(
                text: forum?.description ?? "",
              ),
            ),

            /// **Menampilkan File (Jika Ada)**
            if ((forum?.forumMedia?.isNotEmpty ?? false) &&
                forum?.forumMedia?.first.type == "file")
              MediaFile(forum: forum!),
            if ((forum?.forumMedia?.isNotEmpty ?? false) &&
                forum?.forumMedia?.first.type == "image")
              InkWell(
                onTap: () {
                  ClippedPhotoRoute(idForum: forum?.id ?? 0).go(context);
                },
                child: Stack(
                  fit: StackFit.loose,
                  alignment: Alignment.bottomRight,
                  children: [
                    MediaImages(
                      medias: forum?.forumMedia ?? [],
                    ),
                  ],
                ),
              ),
            if ((forum?.forumMedia?.isNotEmpty ?? false) &&
                forum?.forumMedia?.first.type == "video")
              Stack(
                fit: StackFit.loose,
                alignment: Alignment.bottomRight,
                children: [
                  VideoPlayer(
                    urlVideo: forum?.forumMedia?.first.link ?? "",
                  ),
                ],
              ),
            LikeCommentTop(
              countLike: forum?.likeCount ?? 0,
              countComment: forum?.commentCount ?? 0,
              isLike: forum?.isLike ?? false,
              onPressedLike: () async {},
              onPressedComment: () {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LikeComment(
                countLike: forum?.likeCount ?? 0,
                isLike: forum?.isLike ?? false,
                onPressedLike: () async {
                  await context
                      .read<ForumDetailCubit>()
                      .setLikeUnlikeForum(idForum: forum?.id.toString() ?? "");
                },
                onPressedComment: () {},
              ),
            ),
            (forum?.forumComment?.isEmpty ?? false)
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: forum?.forumComment?.reversed
                            .map(
                              (e) => InkWell(
                                  onTap: () {},
                                  child: CommentForum(
                                    comment: e,
                                    focusNode: focusNode,
                                  )),
                            )
                            .toList() ??
                        []),
          ],
        ),
      ),
    );
  }
}
