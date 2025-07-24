import 'package:flutter/material.dart';

import '../../../misc/colors.dart';

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
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight = screenHeight * 0.35;

    return Container(
      height: containerHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(32),
      ),
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(children: title),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    description,
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    style: descriptionStyle ??
                        const TextStyle(
                          fontSize: 14,
                          color: AppColors.textColor,
                        ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
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
                          ? AppColors.buttonColor1
                          : AppColors.textColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
