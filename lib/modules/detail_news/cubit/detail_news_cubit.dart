import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/repositories/news_repository/news_repository.dart';

import '../../../repositories/news_repository/models/news_detail_model.dart';

part 'detail_news_state.dart';

class DetailNewsCubit extends Cubit<DetailNewsState> {
  DetailNewsCubit() : super(const DetailNewsState());

  NewsRepository repo = getIt<NewsRepository>();

  void copyState({required DetailNewsState newState}) {
    emit(newState);
  }

  Future<void> fetchDetailNews(int newsId) async {
    try {
      final news = await repo.getDetailNews(newsId);
      emit(state.copyWith(news: news, idNews: newsId));
    } catch (e) {
      rethrow;
    }
  }
}
