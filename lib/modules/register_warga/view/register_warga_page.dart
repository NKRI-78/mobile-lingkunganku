import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../widgets/background/custom_background.dart';
import '../../../widgets/button/custom_button.dart';
import '../cubit/register_warga_cubit.dart';
import '../widget/custom_textfield_warga.dart';

class RegisterWargaPage extends StatelessWidget {
  const RegisterWargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterWargaCubit>(
      create: (context) => RegisterWargaCubit(),
      child: RegisterWargaView(),
    );
  }
}

class RegisterWargaView extends StatelessWidget {
  const RegisterWargaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          toolbarHeight: 80,
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
            padding: EdgeInsets.only(top: 85),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  children: [
                    ...customTextfieldsWarga(context),
                    SizedBox(height: 20),
                    CustomButton(
                      horizontalPadding: 110,
                      text: 'Kode OTP',
                      onPressed: () {
                        //
                      },
                    ),
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
