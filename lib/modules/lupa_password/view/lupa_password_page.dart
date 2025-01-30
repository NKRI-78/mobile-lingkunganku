import 'package:flutter/material.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../router/builder.dart';
import '../../../widgets/background/custom_background.dart';
import '../../../widgets/button/custom_button.dart';

class LupaPasswordPage extends StatelessWidget {
  const LupaPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          toolbarHeight: 80,
          title: Text(
            'Reset Password',
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
            padding: EdgeInsets.only(top: 100, left: 32, right: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "Gk usah panik! reset password\ngampang kok. Tinggal klik button\ndibawah ini...",
                    style: AppTextStyles.textStyle2,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 50),
                CustomButton(
                  horizontalPadding: 90,
                  text: 'Reset Password',
                  onPressed: () {
                    LupaPasswordOtpRoute().go(context);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
