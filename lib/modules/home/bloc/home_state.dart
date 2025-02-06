part of 'home_bloc.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<NewsModel> news;
  final int nextPageNews;
  final bool loading;

  const HomeState({
    required this.selectedIndex,
    this.news = const [],
    this.nextPageNews = 1,
    this.loading = false,
  });

  HomeState copyWith({
    int? selectedIndex,
    List<NewsModel>? news,
    int? nextPageNews,
    bool? loading,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      news: news ?? this.news,
      nextPageNews: nextPageNews ?? this.nextPageNews,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object> get props => [selectedIndex, news, nextPageNews, loading];
}
