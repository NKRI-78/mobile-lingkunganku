part of 'nomor_keamanan_section.dart';

void _showKeamananDialog(BuildContext context) {
  final profileCubit = context.read<ProfileCubit>();
  final currentPhone = profileCubit.state.phoneNumberSecurity;

  final TextEditingController phoneController = TextEditingController(
    text: _formatPhoneNumber(currentPhone),
  );

  ValueNotifier<bool> isValid = ValueNotifier(_isValidPhone(currentPhone));

  showDialog(
    context: context,
    builder: (context) {
      return BlocProvider.value(
        value: profileCubit,
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return AlertDialog(
              title: Text(
                "Ubah Nomor Keamanan",
                style: AppTextStyles.textDialog,
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: phoneController,
                    maxLength: 13,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // Hanya angka
                    ],
                    onChanged: (value) {
                      String formatted = _formatPhoneNumber(value);
                      if (phoneController.text != formatted) {
                        phoneController.value = TextEditingValue(
                          text: formatted,
                          selection:
                              TextSelection.collapsed(offset: formatted.length),
                        );
                      }
                      isValid.value = _isValidPhone(formatted);
                    },
                    decoration: InputDecoration(
                      labelText: 'Nomor Keamanan',
                      labelStyle: const TextStyle(color: AppColors.greyColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.greyColor, width: 1.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.secondaryColor, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: isValid,
                    builder: (context, valid, child) {
                      return valid
                          ? const SizedBox.shrink()
                          : Text(
                              "Nomor harus minimal 10 digit!",
                              style: TextStyle(color: Colors.red),
                            );
                    },
                  ),
                ],
              ),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.redColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Batal",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.textProfileBold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ValueListenableBuilder<bool>(
                        valueListenable: isValid,
                        builder: (context, valid, child) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: state.isLoading || !valid
                                ? null
                                : () async {
                                    final newPhone =
                                        phoneController.text.trim();
                                    if (newPhone.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Nomor keamanan tidak boleh kosong")),
                                      );
                                      return;
                                    }

                                    await profileCubit
                                        .updatePhoneSecurity(newPhone);
                                    if (!context.mounted) return;
                                    Navigator.pop(context);
                                  },
                            child: state.isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : Text("Simpan",
                                    style: AppTextStyles.textProfileBold),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    },
  );
}

// Fungsi untuk memastikan nomor selalu diawali dengan "0"
String _formatPhoneNumber(String number) {
  // Hapus semua karakter non-digit
  String cleaned = number.replaceAll(RegExp(r'\D'), '');

  // Pastikan nomor diawali "0"
  if (!cleaned.startsWith("0")) {
    cleaned = "0$cleaned";
  }

  // Batasi panjang maksimal (misal: 13 digit)
  if (cleaned.length > 13) {
    cleaned = cleaned.substring(0, 13);
  }

  return cleaned;
}

// Fungsi untuk validasi nomor minimal 10 digit
bool _isValidPhone(String number) {
  return number.length >= 10;
}
