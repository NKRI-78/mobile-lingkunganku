part of 'home_bloc.dart';

class HomeState extends Equatable {
  final ProfileModel? profile;
  final int selectedIndex;
  final List<NewsModel> news;
  final int nextPageNews;
  final bool isLoading;

  const HomeState({
    this.profile,
    required this.selectedIndex,
    this.news = const [],
    this.nextPageNews = 1,
    this.isLoading = false,
  });

  HomeState copyWith({
    ProfileModel? profile,
    int? selectedIndex,
    List<NewsModel>? news,
    int? nextPageNews,
    bool? isLoading,
  }) {
    return HomeState(
      profile: profile ?? this.profile,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      news: news ?? this.news,
      nextPageNews: nextPageNews ?? this.nextPageNews,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props =>
      [selectedIndex, news, nextPageNews, isLoading, profile];
}
