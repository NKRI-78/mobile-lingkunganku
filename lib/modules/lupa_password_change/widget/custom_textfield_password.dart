part of '../view/lupa_password_change.dart';

class CustomTextFieldPassword extends StatelessWidget {
  const CustomTextFieldPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FieldPassword(),
        _FieldConfirmPassword(),
      ],
    );
  }
}

class _FieldPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LupaPasswordChangeCubit, LupaPasswordChangeState>(
      builder: (context, state) {
        bool isObscured = state.isPasswordObscured;
        return _buildPasswordField(
          label: 'Password',
          onChanged: (value) {
            var cubit = context.read<LupaPasswordChangeCubit>();
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
    return BlocBuilder<LupaPasswordChangeCubit, LupaPasswordChangeState>(
      builder: (context, state) {
        bool isObscured = state.isConfirmPasswordObscured;
        return _buildPasswordField(
          label: 'Konfirmasi Password',
          onChanged: (value) {
            var cubit = context.read<LupaPasswordChangeCubit>();
            cubit.copyState(
                newState: cubit.state.copyWith(passwordConfirm: value));
          },
          isObscured: isObscured,
        );
      },
    );
  }
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
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.whiteColor),
          ),
          child: BlocBuilder<LupaPasswordChangeCubit, LupaPasswordChangeState>(
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
                            .read<LupaPasswordChangeCubit>()
                            .togglePasswordVisibility();
                      } else {
                        context
                            .read<LupaPasswordChangeCubit>()
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
    ),
  );
}
