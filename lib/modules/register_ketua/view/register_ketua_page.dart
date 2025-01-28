import 'dart:ui';
import 'package:flutter/material.dart';
import '../widget/custom_textfield.dart';
import '../../../widgets/background/custom_background.dart';
import '../../../widgets/button/custom_button.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';

class RegisterKetuaPage extends StatelessWidget {
  const RegisterKetuaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          toolbarHeight: 100,
          title: Text(
            'Registrasi',
            style: AppTextStyles.textStyle1,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.buttonColor2,
              size: 32,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white.withOpacity(0.3), Colors.transparent],
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          CustomBackground(),
          Padding(
            padding: EdgeInsets.only(top: 100, bottom: 30),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  children: [
                    ...customTextfields(),
                    SizedBox(height: 5),
                    CustomButton(
                      horizontalPadding: 120,
                      text: 'Kode OTP',
                      onPressed: () {
                        print('INI KLIK OTP');
                      },
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
