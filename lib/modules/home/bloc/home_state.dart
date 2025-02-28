part of 'home_bloc.dart';

@JsonSerializable()
class HomeState extends Equatable {
  final int selectedIndex;
  final List<NewsModel> news;
  final int nextPageNews;
  final bool isLoading;
  final ProfileModel? profile;

  const HomeState({
    this.selectedIndex = 0,
    this.news = const [],
    this.nextPageNews = 1,
    this.isLoading = false,
    this.profile,
  });

  HomeState copyWith({
    int? selectedIndex,
    List<NewsModel>? news,
    int? nextPageNews,
    bool? isLoading,
    ProfileModel? profile,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      news: news ?? this.news,
      nextPageNews: nextPageNews ?? this.nextPageNews,
      isLoading: isLoading ?? this.isLoading,
      profile: profile ?? this.profile,
    );
  }

  factory HomeState.fromJson(Map<String, dynamic> json) =>
      _$HomeStateFromJson(json);
  Map<String, dynamic> toJson() => _$HomeStateToJson(this);

  @override
  List<Object?> get props =>
      [selectedIndex, news, nextPageNews, isLoading, profile];
}
