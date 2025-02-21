import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../widget/customfield_ketua_foto.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../widgets/background/custom_background.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/map/custom_select_map_location.dart';
import '../cubit/register_ketua_cubit.dart';
import '../widget/custom_textfield_ketua.dart';

part '../widget/input_location.dart';
part '../widget/input_location_lebel.dart';

class RegisterKetuaPage extends StatelessWidget {
  const RegisterKetuaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterKetuaCubit>(
      create: (context) => RegisterKetuaCubit(),
      child: RegisterKetuaView(),
    );
  }
}

class RegisterKetuaView extends StatelessWidget {
  RegisterKetuaView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterKetuaCubit, RegisterKetuaState>(
      builder: (context, state) {
        print("Address ${state.currentAddress}");
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
              centerTitle: true,
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        spacing: 20,
                        children: [
                          CustomfieldKetuaFoto(),
                          CustomTextfieldKetua(),
                          SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              text: 'Submit',
                              isLoading: state.isLoading,
                              onPressed: () {
                                context
                                    .read<RegisterKetuaCubit>()
                                    .submit(context);
                              },
                            ),
                          ),
                        ],
                      ),
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
