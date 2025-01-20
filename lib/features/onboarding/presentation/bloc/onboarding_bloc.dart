import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc()
      : super(OnboardingStepChanged(currentStep: 0, totalSteps: 3)) {
    on<NextOnboardingStep>(_onNextOnboardingStep);
    on<PreviousOnboardingStep>(_onPreviousOnboardingStep);
    on<ChangeOnboardingStep>(_onChangeOnboardingStep);
    on<CompleteOnboarding>(_onCompleteOnboarding);
  }

  void _onNextOnboardingStep(
      NextOnboardingStep event, Emitter<OnboardingState> emit) {
    if (state is OnboardingStepChanged) {
      final currentState = state as OnboardingStepChanged;
      final nextStep = currentState.currentStep + 1;
      if (nextStep < currentState.totalSteps) {
        emit(OnboardingStepChanged(
            currentStep: nextStep, totalSteps: currentState.totalSteps));
      } else {
        emit(OnboardingCompleted());
      }
    }
  }

  void _onPreviousOnboardingStep(
      PreviousOnboardingStep event, Emitter<OnboardingState> emit) {
    if (state is OnboardingStepChanged) {
      final currentState = state as OnboardingStepChanged;
      final previousStep = currentState.currentStep - 1;
      if (previousStep >= 0) {
        emit(OnboardingStepChanged(
            currentStep: previousStep, totalSteps: currentState.totalSteps));
      }
    }
  }

  void _onChangeOnboardingStep(
      ChangeOnboardingStep event, Emitter<OnboardingState> emit) {
    if (state is OnboardingStepChanged) {
      final currentState = state as OnboardingStepChanged;
      emit(OnboardingStepChanged(
          currentStep: event.step, totalSteps: currentState.totalSteps));
    }
  }

  void _onCompleteOnboarding(
      CompleteOnboarding event, Emitter<OnboardingState> emit) {
    emit(OnboardingCompleted());
  }
}
