part of 'forum_cubit.dart';

final class ForumState extends Equatable {
  final List<ForumsModel> forums;
  final int nextPageForums;
  final ProfileModel? profile;

  final bool loading;

  const ForumState({
    this.profile,
    this.forums = const [],
    this.nextPageForums = 1,
    this.loading = false,
  });

  @override
  List<Object?> get props => [forums, nextPageForums, loading, profile];

  ForumState copyWith({
    List<ForumsModel>? forums,
    int? nextPageForums,
    bool? loading,
    ProfileModel? profile,
  }) {
    return ForumState(
      forums: forums ?? this.forums,
      nextPageForums: nextPageForums ?? this.nextPageForums,
      loading: loading ?? this.loading,
      profile: profile ?? this.profile,
    );
  }
}
