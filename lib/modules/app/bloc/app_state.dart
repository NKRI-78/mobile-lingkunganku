part of 'app_bloc.dart';

@JsonSerializable()
final class AppState extends Equatable {
  final bool alreadyOnboarding;

  const AppState({
    this.alreadyOnboarding = false,
  });

  AppState copyWith({
    bool? alreadyOnboarding,
  }) {
    return AppState(
      alreadyOnboarding: alreadyOnboarding ?? this.alreadyOnboarding,
    );
  }

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);

  @override
  List<Object> get props => [alreadyOnboarding];
}

final class AppInitial extends AppState {}
