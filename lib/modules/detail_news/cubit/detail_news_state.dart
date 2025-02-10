part of 'detail_news_cubit.dart';

final class DetailNewsState {
  final int idNews;
  final DetailNewsModel? news;

  const DetailNewsState({
    this.idNews = 0,
    this.news,
  });

  DetailNewsState copyWith({
    int? idNews,
    DetailNewsModel? news,
  }) {
    return DetailNewsState(
      idNews: idNews ?? this.idNews,
      news: news ?? this.news,
    );
  }
}
