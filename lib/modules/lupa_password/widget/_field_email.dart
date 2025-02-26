part of '../view/lupa_password_page.dart';

class _FieldEmail extends StatelessWidget {
  const _FieldEmail();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LupaPasswordCubit, LupaPasswordState>(
        builder: (context, state) {
      return _buildTextFormField(
        label: 'Masukan Email Anda',
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          var cubit = context.read<LupaPasswordCubit>();
          cubit.copyState(newState: cubit.state.copyWith(email: value));
        },
      );
    });
  }
}

Widget _buildTextFormField({
  required String label,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
  int maxLines = 1,
  required ValueChanged<String> onChanged,
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
          maxLines: maxLines,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
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
