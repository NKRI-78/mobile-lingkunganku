part of 'onboarding_bloc.dart';

abstract class OnboardingEvent {}

class StartOnboarding extends OnboardingEvent {}

class NextOnboardingStep extends OnboardingEvent {}

class PreviousOnboardingStep extends OnboardingEvent {}

class ChangeOnboardingStep extends OnboardingEvent {
  final int step;

  ChangeOnboardingStep(this.step);
}

class CompleteOnboarding extends OnboardingEvent {}
