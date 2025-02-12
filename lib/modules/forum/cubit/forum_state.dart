part of 'forum_cubit.dart';

final class ForumState extends Equatable {
  final List<ForumsModel> forums;
  final int nextPageForums;

  final bool loading;

  const ForumState({
    this.forums = const [],
    this.nextPageForums = 1,
    this.loading = false,
  });

  @override
  List<Object?> get props => [
        forums,
        nextPageForums,
        loading,
      ];

  ForumState copyWith({
    List<ForumsModel>? forums,
    int? nextPageForums,
    bool? loading,
  }) {
    return ForumState(
      forums: forums ?? this.forums,
      nextPageForums: nextPageForums ?? this.nextPageForums,
      loading: loading ?? this.loading,
    );
  }
}
