import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../router/builder.dart';
import '../../../widgets/background/custom_background.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Pilih jenis akun\nanda',
          style: TextStyle(
            color: AppColors.textColor2,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'Intel',
          ),
        ),
        centerTitle: true,
        toolbarHeight: 140,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.buttonColor2,
            size: 24,
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        top: false,
        bottom: true,
        child: Stack(
          children: [
            const CustomBackground(),
            CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.only(
                      top: 150, left: 30, right: 30, bottom: 30),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const SizedBox(height: 100),
                        GestureDetector(
                          onTap: () {
                            RegisterKetuaRoute().go(context);
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(
                                    color: AppColors.buttonColor2,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Ketua /\nPengurus        ',
                                      style: AppTextStyles.textRegister2,
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'Pilih opsi jika anda\nKetua/Pengurus\nlingkungan setempat.',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.textColor2
                                            .withOpacity(0.5),
                                        fontFamily: 'Intel',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 15,
                                top: -50,
                                bottom: 0,
                                child: Image.asset(
                                  'assets/images/ketua.png',
                                  // height: 100,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 100),
                        GestureDetector(
                          onTap: () {
                            // Navigasi ke halaman registrasi Warga/Keluarga
                            print('Masuk ke Warga : ${context}');
                            RegisterWargaRoute().go(context);
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
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
                                      'Warga',
                                      style: AppTextStyles.textRegister2,
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'Pilih opsi jika anda\nsebagai Warga, dengan\nsyarat ketua lingkungan\nanda sudah buat akun.',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.textColor2
                                            .withOpacity(0.5),
                                        fontFamily: 'Intel',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 10,
                                top: -50,
                                bottom: 0,
                                child: Image.asset(
                                  'assets/images/warga.png',
                                  // height: 100,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
