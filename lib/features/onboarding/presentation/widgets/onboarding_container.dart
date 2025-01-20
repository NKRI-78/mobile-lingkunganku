import 'package:flutter/material.dart';
import '../../../../core/utils/colors.dart';

class OnboardingContainer extends StatelessWidget {
  final List<TextSpan> title;
  final String description;
  final int currentIndex;
  final int totalSteps;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  const OnboardingContainer({
    super.key,
    required this.title,
    required this.description,
    required this.currentIndex,
    required this.totalSteps,
    this.titleStyle,
    this.descriptionStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(32),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Column(
              children: [
                RichText(
                  text: TextSpan(children: title),
                ),
                const SizedBox(height: 20),
                Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: descriptionStyle ??
                      const TextStyle(
                        fontSize: 16,
                        color: AppColors.textColor,
                      ),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                totalSteps,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: currentIndex == index ? 10 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? AppColors.buttonColor
                        : AppColors.textColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
