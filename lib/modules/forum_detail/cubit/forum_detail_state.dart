part of 'forum_detail_cubit.dart';

class ForumDetailState extends Equatable {
  final ForumDetailModel? detailForum;
  final String idForum;
  final String inputComment;
  final bool loading;
  final bool loadingComment;
  final int initIndex;
  final int idOrder;
  final int commentId;
  final int? lastIdComment;

  const ForumDetailState({
    this.detailForum,
    this.idForum = "",
    this.inputComment = "",
    this.loading = false,
    this.loadingComment = false,
    this.initIndex = 0,
    this.idOrder = 0,
    this.commentId = 0,
    this.lastIdComment = 0,
  });

  @override
  List<dynamic> get props => [
        detailForum,
        idForum,
        inputComment,
        loading,
        loadingComment,
        initIndex,
        idOrder,
        commentId,
        lastIdComment,
      ];

  ForumDetailState copyWith({
    ForumDetailModel? detailForum,
    String? idForum,
    String? inputComment,
    bool? loading,
    bool? loadingComment,
    int? initIndex,
    int? idOrder,
    int? commentId,
    int? lastIdComment,
  }) {
    return ForumDetailState(
      detailForum: detailForum ?? this.detailForum,
      idForum: idForum ?? this.idForum,
      inputComment: inputComment ?? this.inputComment,
      loading: loading ?? this.loading,
      loadingComment: loadingComment ?? this.loadingComment,
      initIndex: initIndex ?? this.initIndex,
      idOrder: idOrder ?? this.idOrder,
      commentId: commentId ?? this.commentId,
      lastIdComment: lastIdComment ?? this.lastIdComment,
    );
  }
}
