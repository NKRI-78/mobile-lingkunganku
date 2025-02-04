import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/modules/onboarding/cubit/onboarding_cubit.dart';

import '../../../router/builder.dart';
import '../models/onboarding_data.dart';
import '../widget/onboarding_pageview.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingCubit>(
      create: (context) => OnboardingCubit(),
      child: const OnboardingView(),
    );
  }
}

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void nextPage() {
    if (_currentIndex < onboardingContent.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void finishOnboarding() {
    HomeRoute().go(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: onboardingContent.length,
            itemBuilder: (context, index) {
              final content = onboardingContent[index];
              return OnboardingPageView(
                title: content['title']!,
                description: content['description']!,
                image: content['image']!,
                currentIndex: _currentIndex,
                totalSteps: onboardingContent.length,
                onNext: nextPage,
                onFinish: () {
                  context.read<OnboardingCubit>().finishOnboarding(context);
                  HomeRoute().go(context);
                },
                titleStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontFamily: 'Inter'),
                descriptionStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontFamily: 'Inter',
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
