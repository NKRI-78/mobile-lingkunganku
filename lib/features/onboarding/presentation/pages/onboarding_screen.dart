import 'package:flutter/material.dart';
import '../../data/onboarding_data.dart';
import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
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
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/onboarding_bg.png',
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
              return OnboardingPage(
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
