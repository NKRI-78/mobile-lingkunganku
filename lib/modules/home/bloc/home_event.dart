part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInit extends HomeEvent {
  final BuildContext? context;

  HomeInit({this.context});
}

class HomeNavigate extends HomeEvent {
  final int index;
  HomeNavigate(this.index);

  @override
  List<Object?> get props => [index];
}

final class HomeCopyState extends HomeEvent {
  final HomeState newState;

  HomeCopyState({required this.newState});
}

class HomeFetchMoreNews extends HomeEvent {
  final bool isRefresh;

  HomeFetchMoreNews(this.isRefresh);

  @override
  List<Object> get props => [isRefresh];
}

class LoadProfile extends HomeEvent {}
