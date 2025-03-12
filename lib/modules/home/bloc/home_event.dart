part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeInit extends HomeEvent {
  final BuildContext? context;

  const HomeInit({this.context});
}

class HomeNavigate extends HomeEvent {
  final int index;
  const HomeNavigate(this.index);

  @override
  List<Object?> get props => [index];
}

class HomeCopyState extends HomeEvent {
  final HomeState newState;
  const HomeCopyState(this.newState);

  @override
  List<Object?> get props => [newState];
}

class LoadProfile extends HomeEvent {}
