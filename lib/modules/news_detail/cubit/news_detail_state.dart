part of 'news_detail_cubit.dart';

final class NewsDetailState extends Equatable {
  final int idNews;
  final DetailNewsModel? news;
  final bool loading;
  final ProfileModel? profile;

  const NewsDetailState({
    this.idNews = 0,
    this.news,
    this.loading = false,
    this.profile,
  });

  NewsDetailState copyWith({
    int? idNews,
    DetailNewsModel? news,
    bool? loading,
    ProfileModel? profile,
  }) {
    return NewsDetailState(
      idNews: idNews ?? this.idNews,
      news: news ?? this.news,
      loading: loading ?? this.loading,
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object?> get props => [
        idNews,
        news,
        loading,
        profile,
      ];
}
