part of 'show_more_news_cubit.dart';

final class ShowMoreNewsState extends Equatable {
  final List<NewsModel> news;
  final int nextPageNews;
  final PaginationModel? newsPagination;
  final bool loading;
  final ProfileModel? profile;

  const ShowMoreNewsState({
    this.news = const [],
    this.nextPageNews = 1,
    this.newsPagination,
    this.loading = false,
    this.profile,
  });

  @override
  List<Object?> get props => [
        news,
        nextPageNews,
        newsPagination,
        loading,
        profile,
      ];

  ShowMoreNewsState copyWith({
    List<NewsModel>? news,
    int? nextPageNews,
    PaginationModel? newsPagination,
    bool? loading,
    ProfileModel? profile,
  }) {
    return ShowMoreNewsState(
      news: news ?? this.news,
      nextPageNews: nextPageNews ?? this.nextPageNews,
      newsPagination: newsPagination ?? this.newsPagination,
      loading: loading ?? this.loading,
      profile: profile ?? this.profile,
    );
  }
}
