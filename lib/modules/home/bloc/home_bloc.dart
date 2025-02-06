import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/home_repository/home_repository.dart';
import '../../../repositories/home_repository/models/data_pagination.dart';
import '../../../repositories/home_repository/models/news_model.dart';

part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;

  HomeBloc(this._homeRepository) : super(const HomeState(selectedIndex: 0)) {
    on<HomeInit>((event, emit) async {
      await fetchNews(emit, isRefresh: true);
    });

    on<HomeNavigate>((event, emit) {
      emit(state.copyWith(selectedIndex: event.index));
    });

    on<HomeFetchMoreNews>((event, emit) async {
      await fetchNews(emit);
    });

    on<HomeCopyState>((event, emit) {
      emit(event.newState);
    });
  }

  Future<void> fetchNews(Emitter<HomeState> emit,
      {bool isRefresh = false}) async {
    if (state.loading) return;

    emit(state.copyWith(loading: true));
    try {
      final int nextPage = isRefresh ? 1 : state.nextPageNews;
      DataPagination<NewsModel> newsData =
          await _homeRepository.getNews(page: nextPage);

      emit(state.copyWith(
        news: isRefresh ? newsData.list : [...state.news, ...newsData.list],
        nextPageNews: newsData.paginate.next ?? state.nextPageNews,
      ));
    } catch (e) {
      print('Error fetching news: $e');
    } finally {
      emit(state.copyWith(loading: false));
    }
  }
}
