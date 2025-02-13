import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
    return BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
      builder: (context, state) {
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
                  GoRouter.of(context).pop();
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
                        CustomTextfieldWarga(),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            text: 'Submit',
                            isLoading: state.isLoading,
                            onPressed: () {
                              context
                                  .read<RegisterWargaCubit>()
                                  .submit(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
