import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../router/builder.dart';
import '../../../widgets/background/custom_background.dart';
import '../../../widgets/button/custom_button.dart';
import '../cubit/login_cubit.dart';
import '../widget/custom_textfield_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: AppBar(
              surfaceTintColor: Colors.transparent,
              toolbarHeight: 80,
              title: Text(
                'Login',
                style: AppTextStyles.textStyle1,
              ),
              centerTitle: true,
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
                padding: const EdgeInsets.only(top: 85),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/icons/lingkunganku.png',
                            width: 200,
                            height: 300,
                          ),
                        ),
                        CustomTextfieldLogin(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 5,
                          children: [
                            Text(
                              "Klik",
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Intel',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                LupaPasswordRoute().go(context);
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
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Intel',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            isLoading: state.loading,
                            text: 'Masuk',
                            onPressed: () {
                              context.read<LoginCubit>().submit(context);
                            },
                          ),
                        )
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
