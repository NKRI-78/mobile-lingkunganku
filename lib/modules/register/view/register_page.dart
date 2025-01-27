import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/misc/text_style.dart';
import 'package:mobile_lingkunganku/widgets/background/custom_background.dart';
import 'package:mobile_lingkunganku/widgets/button/custom_button.dart';

import '../widget/custom_divider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100,
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
      ),
      body: Stack(
        children: [
          const CustomBackground(),
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(30),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(height: 70),
                      Text(
                        'Pilih role di bawah\nini untuk melanjutkan\nregistrasi',
                        style: TextStyle(
                          color: AppColors.textColor2,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Intel',
                        ),
                      ),
                      const SizedBox(height: 50),
                      GestureDetector(
                        onTap: () {
                          // Navigasi ke halaman registrasi Ketua/Pengurus
                          print('Masuk ke Ketua : ${context}');
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              padding: const EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(
                                  color: AppColors.buttonColor2,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Registrasi',
                                    style: AppTextStyles.textRegister1,
                                  ),
                                  Text(
                                    'Ketua / Pengurus',
                                    style: AppTextStyles.textRegister2,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 10,
                              top: -60,
                              bottom: -10,
                              child: Image.asset(
                                'assets/images/ketua.png',
                                // height: 100,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 70),
                      GestureDetector(
                        onTap: () {
                          // Navigasi ke halaman registrasi Warga/Keluarga
                          print('Masuk ke Warga : ${context}');
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              padding: const EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(
                                  color: AppColors.buttonColor2,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Registrasi',
                                    style: AppTextStyles.textRegister1,
                                  ),
                                  Text(
                                    'Warga / Keluarga',
                                    style: AppTextStyles.textRegister2,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: -60,
                              bottom: -10,
                              child: Image.asset(
                                'assets/images/warga.png',
                                // height: 100,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomDivider(),
                      const SizedBox(height: 30),
                      Center(
                        child: CustomButton(
                          horizontalPadding: 100,
                          text: 'Login',
                          onPressed: () {
                            // navigate to login
                            print('KLIK UNTK LOGIN');
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 7,
                        children: [
                          Text(
                            "Klik",
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Intel',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to resetpassword
                              print('KLIK DISINI PINDAH HALAMAN PASSWORD');
                            },
                            child: Text(
                              "Disini",
                              style: TextStyle(
                                color: AppColors.redColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Intel',
                              ),
                            ),
                          ),
                          Text(
                            "jika lupa Password",
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Intel',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
