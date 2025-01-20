import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';

class OnboardingButton extends StatelessWidget {
  final int currentIndex;
  final int totalSteps;
  final VoidCallback onNext;
  final VoidCallback onFinish;

  const OnboardingButton({
    super.key,
    required this.currentIndex,
    required this.totalSteps,
    required this.onNext,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0),
      child: Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: currentIndex < totalSteps - 1 ? onNext : onFinish,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 15,
            ),
          ),
          child: Text(
            currentIndex == totalSteps - 1 ? 'HOME' : 'SELANJUTNYA',
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ),
    );
  }
}
