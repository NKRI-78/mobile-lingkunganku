import 'package:flutter/material.dart';

import '../../misc/injections.dart';
import '../../modules/app/bloc/app_bloc.dart';

class TermCondition extends StatelessWidget {
  const TermCondition({super.key});

  @override
  Widget build(BuildContext context) {
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
                    top: -250,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/termCondition.png',
                        width: 300,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 30,
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/icons/lingkunganku.png',
                          width: 150,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Column(children: [
                          Text(
                            "I'ts important that you understand what information Lingkunganku Mobile collects.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "● Your Information & Content",
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "This may include any information you share with us, for example :",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "your create a post and another users can like your post or comment also you can delete your post.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "● Photos, Videos & Documents\nThis may include your can post on media photos, videos, or documents",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "● Embedded Links\nThis may include your can post on link sort of news, etc",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                          SizedBox(height: 50),
                        ]),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff1B5E20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 50),
                          ),
                          onPressed: () async {
                            getIt<AppBloc>().add(FinishTermCondition());
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Lanjutkan',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
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
