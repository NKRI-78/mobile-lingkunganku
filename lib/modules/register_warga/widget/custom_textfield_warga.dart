import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../widgets/terms_of_services/pdf_view.dart';
import '../cubit/register_warga_cubit.dart';

class CustomTextfieldWarga extends StatelessWidget {
  const CustomTextfieldWarga({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FieldName(),
        _FieldGender(),
        SizedBox(height: 10),
        _FieldEmail(),
        _FieldPhone(),
        SizedBox(height: 10),
        _FieldDetailAddress(),
        _FieldPassword(),
        _FieldConfirmPassword(),
        _FieldReferalCode(),
        _FieldTermsOfService(),
      ],
    );
  }
}

class _FieldName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return _buildTextFormField(
          label: 'Nama Lengkap',
          onChanged: (value) {
            context.read<RegisterWargaCubit>().copyState(
                newState: context
                    .read<RegisterWargaCubit>()
                    .state
                    .copyWith(name: value));
          },
        );
      },
    );
  }
}

class _FieldGender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
      buildWhen: (previous, current) => previous.gender != current.gender,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Jenis Kelamin', style: AppTextStyles.textStyle2),
              Row(
                children: [
                  Checkbox(
                    value: state.gender == 'L',
                    onChanged: (bool? value) {
                      if (value == true) {
                        context.read<RegisterWargaCubit>().updateGender('L');
                      } else if (state.gender == 'L') {
                        context.read<RegisterWargaCubit>().updateGender('-');
                      }
                    },
                    activeColor: AppColors.buttonColor1,
                    side: BorderSide(color: AppColors.whiteColor, width: 1.5),
                  ),
                  Text('Laki - Laki',
                      style: TextStyle(color: AppColors.textColor2)),
                  SizedBox(width: 20),
                  Checkbox(
                    value: state.gender == 'P',
                    onChanged: (bool? value) {
                      if (value == true) {
                        context.read<RegisterWargaCubit>().updateGender('P');
                      } else if (state.gender == 'P') {
                        context.read<RegisterWargaCubit>().updateGender('-');
                      }
                    },
                    activeColor: AppColors.buttonColor1,
                    side: BorderSide(color: AppColors.whiteColor, width: 1.5),
                  ),
                  Text('Perempuan',
                      style: TextStyle(color: AppColors.textColor2)),
                ],
              ),
              Text(
                '*Opsional: Anda dapat memilih jenis kelamin atau melewati pilihan ini.',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textColor2.withOpacity(0.6),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FieldEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return _buildTextFormField(
          label: 'Alamat Email',
          onChanged: (value) {
            var cubit = context.read<RegisterWargaCubit>();
            cubit.copyState(newState: cubit.state.copyWith(email: value));
          },
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
        );
      },
    );
  }
}

class _FieldPhone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextFormField(
              maxLength: 13,
              label: 'Nomor Telepon',
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                var cubit = context.read<RegisterWargaCubit>();
                cubit.copyState(newState: cubit.state.copyWith(phone: value));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                '*Opsional: Anda dapat mengisi nomor handphone atau melewati pilihan ini.',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textColor2.withOpacity(0.6),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FieldDetailAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
      buildWhen: (previous, current) =>
          previous.detailAddress != current.detailAddress,
      builder: (context, state) {
        return _buildTextFormField(
          label: 'Detail Alamat',
          maxLines: 4,
          onChanged: (value) {
            var cubit = context.read<RegisterWargaCubit>();
            cubit.copyState(
                newState: cubit.state.copyWith(detailAddress: value));
          },
        );
      },
    );
  }
}

class _FieldPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
      builder: (context, state) {
        bool isObscured = state.isPasswordObscured;
        return _buildPasswordField(
          label: 'Password',
          onChanged: (value) {
            var cubit = context.read<RegisterWargaCubit>();
            cubit.copyState(newState: cubit.state.copyWith(password: value));
          },
          isObscured: isObscured,
        );
      },
    );
  }
}

class _FieldConfirmPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
      builder: (context, state) {
        bool isObscured = state.isConfirmPasswordObscured;
        return _buildPasswordField(
          label: 'Konfirmasi Password',
          onChanged: (value) {
            var cubit = context.read<RegisterWargaCubit>();
            cubit.copyState(
                newState: cubit.state.copyWith(passwordConfirm: value));
          },
          isObscured: isObscured,
        );
      },
    );
  }
}

class _FieldReferalCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
      builder: (context, state) {
        return _buildTextFormField(
          label: 'Referal Code',
          onChanged: (value) {
            var cubit = context.read<RegisterWargaCubit>();
            cubit.copyState(newState: cubit.state.copyWith(referral: value));
          },
        );
      },
    );
  }
}

class _FieldTermsOfService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
      buildWhen: (previous, current) =>
          previous.isTermsAccepted != current.isTermsAccepted,
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: state.isTermsAccepted,
              onChanged: (bool? value) {
                context
                    .read<RegisterWargaCubit>()
                    .toggleTermsAcceptance(value ?? false);
              },
              activeColor: AppColors.buttonColor1,
              side: BorderSide(color: AppColors.whiteColor, width: 1.5),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const TermsPdfPage(),
                    ),
                  );
                },
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: TextStyle(color: AppColors.textColor2, fontSize: 14),
                    children: [
                      TextSpan(
                        text:
                            'Dengan mendaftar, saya menyatakan bahwa saya telah membaca dan menyetujui ',
                      ),
                      TextSpan(
                        text: 'Syarat & Ketentuan',
                        style: TextStyle(
                          color: AppColors.buttonColor1,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: ', serta bersedia menjadi bagian dari warga',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget _buildTextFormField({
  required String label,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
  int maxLines = 1,
  required ValueChanged<String> onChanged,
  List<TextInputFormatter>? inputFormatters,
  int? maxLength,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.whiteColor),
        ),
        child: TextFormField(
          maxLength: maxLength,
          maxLines: maxLines,
          keyboardType: keyboardType,
          obscureText: obscureText,
          textCapitalization:
              (label == 'Nama Lengkap' || label == 'Detail Alamat')
                  ? TextCapitalization.words
                  : TextCapitalization.none,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: AppColors.buttonColor1),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          ),
          style: TextStyle(color: AppColors.textColor2),
        ),
      ),
    ),
  );
}

Widget _buildPasswordField({
  required String label,
  required ValueChanged<String> onChanged,
  required bool isObscured,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.whiteColor),
        ),
        child: BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
          builder: (context, state) {
            return TextFormField(
              obscureText: isObscured,
              onChanged: onChanged,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(color: AppColors.buttonColor1),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                suffixIcon: IconButton(
                  icon: Icon(
                    isObscured ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.buttonColor1,
                  ),
                  onPressed: () {
                    // Ensure context is available and update visibility through Cubit
                    if (label == 'Password') {
                      context
                          .read<RegisterWargaCubit>()
                          .togglePasswordVisibility();
                    } else {
                      context
                          .read<RegisterWargaCubit>()
                          .toggleConfirmPasswordVisibility();
                    }
                  },
                ),
              ),
              style: TextStyle(color: AppColors.textColor2),
            );
          },
        ),
      ),
    ),
  );
}
