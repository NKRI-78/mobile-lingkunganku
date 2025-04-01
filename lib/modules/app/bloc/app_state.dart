part of 'app_bloc.dart';

@JsonSerializable()
final class AppState extends Equatable {
  final NotificationCountModel? badges;
  final IuranCountModel? iuranBadges;
  final bool alreadyOnboarding;
  final User? user;
  final String token;
  final bool loadingNotif;
  final ProfileModel? profile;

  const AppState({
    this.profile,
    this.badges,
    this.iuranBadges,
    this.alreadyOnboarding = false,
    this.user,
    this.token = '',
    this.loadingNotif = false,
  });

  bool get isLogin => token != '' && user != null;
  bool get isAlreadyLogin => user != null && token.isNotEmpty;
  bool get userEmpty => token.isEmpty;

  @override
  List<Object?> get props => [
        alreadyOnboarding,
        user,
        token,
        loadingNotif,
        badges,
        profile,
        iuranBadges,
      ];

  AppState logout() {
    return AppState(
      alreadyOnboarding: alreadyOnboarding,
      token: '',
      user: null,
    );
  }

  AppState copyWith({
    NotificationCountModel? badges,
    IuranCountModel? iuranBadges,
    bool? alreadyOnboarding,
    User? user,
    String? token,
    bool? loadingNotif,
    ProfileModel? profile,
  }) {
    return AppState(
      badges: badges ?? this.badges,
      iuranBadges: iuranBadges ?? this.iuranBadges,
      alreadyOnboarding: alreadyOnboarding ?? this.alreadyOnboarding,
      user: user ?? this.user,
      profile: profile ?? this.profile,
      token: token ?? this.token,
      loadingNotif: loadingNotif ?? this.loadingNotif,
    );
  }

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}

final class AppInitial extends AppState {}
