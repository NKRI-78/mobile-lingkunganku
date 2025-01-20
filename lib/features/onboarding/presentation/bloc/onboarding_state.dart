part of 'onboarding_bloc.dart';

abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoading extends OnboardingState {}

class OnboardingStepChanged extends OnboardingState {
  final int currentStep;
  final int totalSteps;

  OnboardingStepChanged({required this.currentStep, required this.totalSteps});
}

class OnboardingCompleted extends OnboardingState {}
