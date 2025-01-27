import 'package:flutter/material.dart';

import '../../../router/builder.dart';
import '../models/onboarding_data.dart';
import '../widget/onboarding_pageview.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingPage> {
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
                onFinish: finishOnboarding,
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
