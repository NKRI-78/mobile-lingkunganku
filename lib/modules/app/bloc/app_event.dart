part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

final class FinishOnboarding extends AppEvent {}

final class SetUserLogout extends AppEvent {}

final class SetUserData extends AppEvent {
  final User user;
  final String token;

  const SetUserData({required this.user, required this.token});
}

final class GetBadgeNotif extends AppEvent {}
