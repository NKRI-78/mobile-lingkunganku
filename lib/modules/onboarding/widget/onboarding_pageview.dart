import 'package:flutter/material.dart';

import 'onboarding_button.dart';
import 'onboarding_container.dart';

class OnboardingPageView extends StatelessWidget {
  final List<TextSpan> title;
  final String description;
  final String image;
  final int currentIndex;
  final int totalSteps;
  final VoidCallback onNext;
  final VoidCallback onFinish;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  const OnboardingPageView({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.currentIndex,
    required this.totalSteps,
    required this.onNext,
    required this.onFinish,
    this.titleStyle,
    this.descriptionStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * 0.02,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/icons/lingkunganku.png',
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.2,
          left: 0,
          right: 0,
          child: Image.asset(
            image,
            height: 250,
          ),
        ),
        Positioned(
          bottom: 75,
          left: 16,
          right: 16,
          child: OnboardingContainer(
            title: title,
            description: description,
            currentIndex: currentIndex,
            totalSteps: totalSteps,
            titleStyle: titleStyle,
            descriptionStyle: descriptionStyle,
          ),
        ),
        Positioned(
          bottom: 30,
          left: 16,
          right: 16,
          child: OnboardingButton(
            currentIndex: currentIndex,
            totalSteps: totalSteps,
            onNext: onNext,
            onFinish: onFinish,
          ),
        ),
      ],
    );
  }
}
