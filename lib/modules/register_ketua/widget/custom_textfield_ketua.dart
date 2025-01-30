import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../cubit/register_ketua_cubit.dart';
import '../view/register_ketua_page.dart';

List<Widget> customTextfieldsKetua(BuildContext context) {
  return [
    _buildTextField(label: 'Nama Lengkap'),
    _buildTextField(label: 'Alamat Email'),
    _buildTextField(label: 'No Handphone', keyboardType: TextInputType.phone),
    Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Registrasi Komplek",
          style: TextStyle(
            fontSize: 20,
            color: AppColors.textColor2,
            fontFamily: 'Intel',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    _buildTextField(label: 'Nama Lingkungan / Komplek'),
    _buildTextField(label: 'Detail Alamat', maxLines: 4),
    // PIN POINT MAPS
    const InputLocationLabel(),
    const InputLocation(),
    SizedBox(height: 20),
    _buildDropdown(context), // Dropdown Button

    _buildPasswordField(label: 'Password'),
    _buildPasswordField(label: 'Konfirmasi Password'),
  ];
}

// Password field widget updated to use cubit state
Widget _buildPasswordField({required String label}) {
  return BlocBuilder<RegisterKetuaCubit, RegisterKetuaState>(
    builder: (context, state) {
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
              child: TextField(
                obscureText: label == 'Password'
                    ? state.isPasswordObscured
                    : state.isConfirmPasswordObscured,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(color: AppColors.buttonColor1),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  suffixIcon: IconButton(
                    icon: Icon(
                      label == 'Password'
                          ? (state.isPasswordObscured
                              ? Icons.visibility_off
                              : Icons.visibility)
                          : (state.isConfirmPasswordObscured
                              ? Icons.visibility_off
                              : Icons.visibility),
                      color: AppColors.buttonColor1,
                    ),
                    onPressed: () {
                      if (label == 'Password') {
                        context
                            .read<RegisterKetuaCubit>()
                            .togglePasswordVisibility();
                      } else {
                        context
                            .read<RegisterKetuaCubit>()
                            .toggleConfirmPasswordVisibility();
                      }
                    },
                  ),
                ),
                style: TextStyle(color: AppColors.textColor2),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildDropdown(BuildContext context) {
  return BlocBuilder<RegisterKetuaCubit, RegisterKetuaState>(
    builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Text(
              'Jumlah Penghuni',
              style: TextStyle(
                color: AppColors.buttonColor1,
                fontWeight: FontWeight.normal,
                fontFamily: 'Intel',
                fontSize: 16,
              ),
            ),
            SizedBox(width: 30),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: DropdownButton<int>(
                  value:
                      state.selectedPenghuni != 0 ? state.selectedPenghuni : 1,
                  isExpanded: true,
                  dropdownColor: Colors.green[100],
                  underline: SizedBox(),
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  items: [
                    const DropdownMenuItem<int>(
                      value: 0,
                      child: Text('Pilih jumlah penghuni'),
                    ),
                    ...List.generate(50, (index) => index + 1).map(
                      (e) => DropdownMenuItem<int>(
                        value: e,
                        child: Text('$e', style: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ],
                  onChanged: (value) =>
                      context.read<RegisterKetuaCubit>().selectPenghuni(value!),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildTextField({
  required String label,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
  int maxLines = 1,
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
          child: TextField(
            maxLines: maxLines,
            keyboardType: keyboardType,
            obscureText: obscureText,
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
    ),
  );
}
