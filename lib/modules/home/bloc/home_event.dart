part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInit extends HomeEvent {}

class HomeNavigate extends HomeEvent {
  final int index;
  HomeNavigate(this.index);

  @override
  List<Object?> get props => [index];
}
