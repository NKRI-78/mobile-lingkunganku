import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/bloc/app_bloc.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState());
  static PageController pageController = PageController();

  void changeIndex(int index) {
    emit(state.copyWith(index: index));
  }

  void nextPage() {
    OnboardingCubit.pageController.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void finishOnboarding(BuildContext context) async {
    context.read<AppBloc>().add(FinishOnboarding());
    // await determinePosition(context);
  }
}
