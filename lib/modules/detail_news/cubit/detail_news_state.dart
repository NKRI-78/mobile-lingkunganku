part of 'detail_news_cubit.dart';

final class DetailNewsState {
  final int idNews;
  final DetailNewsModel? news;
  final bool loading;

  const DetailNewsState({
    this.idNews = 0,
    this.news,
    this.loading = false,
  });

  DetailNewsState copyWith({
    int? idNews,
    DetailNewsModel? news,
    bool? loading,
  }) {
    return DetailNewsState(
      idNews: idNews ?? this.idNews,
      news: news ?? this.news,
      loading: loading ?? this.loading,
    );
  }
}
