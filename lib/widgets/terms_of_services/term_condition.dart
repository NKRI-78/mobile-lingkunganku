import 'package:flutter/material.dart';

import '../../misc/injections.dart';
import '../../modules/app/bloc/app_bloc.dart';

class TermCondition extends StatelessWidget {
  const TermCondition({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xffE8F5E9),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -screenHeight * 0.25,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/termCondition.png',
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.25,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SafeArea(
                    bottom: true,
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 30),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/icons/lingkunganku.png',
                              width: screenWidth * 0.4,
                            ),
                            const SizedBox(height: 20),
                            ...[
                              "It's important that you understand what information Lingkunganku Mobile collects.",
                              "● Your Information & Content",
                              "This may include any information you share with us, for example:",
                              "You create a post and other users can like or comment on it. You can also delete your post.",
                              "● Photos, Videos & Documents\nYou can post media such as photos, videos, or documents.",
                              "● Embedded Links\nYou can post links to news or other content."
                            ].map((text) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    text,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.03,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                    ),
                                  ),
                                )),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff1B5E20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                              ),
                              onPressed: () {
                                getIt<AppBloc>().add(FinishTermCondition());
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Lanjutkan',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
