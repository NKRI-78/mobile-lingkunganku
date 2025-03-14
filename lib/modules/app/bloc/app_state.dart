part of 'app_bloc.dart';

@JsonSerializable()
final class AppState extends Equatable {
  final bool alreadyOnboarding;
  final User? user;
  final String token;

  const AppState({
    this.alreadyOnboarding = false,
    this.user,
    this.token = '',
  });

  bool get isLogin => token != '' && user != null;
  bool get isAlreadyLogin => user != null && token.isNotEmpty;
  bool get userEmpty => token.isEmpty;

  @override
  List<Object?> get props => [alreadyOnboarding, user, token];

  AppState logout() {
    return AppState(
      alreadyOnboarding: alreadyOnboarding,
      token: '',
      user: null,
    );
  }

  AppState copyWith({
    bool? alreadyOnboarding,
    User? user,
    String? token,
  }) {
    return AppState(
      alreadyOnboarding: alreadyOnboarding ?? this.alreadyOnboarding,
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}

final class AppInitial extends AppState {}
