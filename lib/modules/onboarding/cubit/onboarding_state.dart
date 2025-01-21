part of 'onboarding_cubit.dart';

final class OnboardingState extends Equatable {
  final int index;
  const OnboardingState({this.index = 0});

  @override
  List<Object> get props => [index];
  OnboardingState copyWith({
    int? index,
  }) {
    return OnboardingState(
      index: index ?? this.index,
    );
  }
}
