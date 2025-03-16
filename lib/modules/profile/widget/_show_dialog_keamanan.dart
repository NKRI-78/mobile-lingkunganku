part of 'nomor_keamanan_section.dart';

void _showKeamananDialog(BuildContext context) {
  final profileCubit = context.read<ProfileCubit>();
  final currentPhone =
      profileCubit.state.profile?.neighborhood?.phoneSecurity ?? "";
  final TextEditingController phoneController =
      TextEditingController(text: currentPhone);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Ubah Nomor Keamanan",
          style: AppTextStyles.textDialog,
          textAlign: TextAlign.center,
        ),
        content: TextFormField(
          controller: phoneController,
          maxLength: 13,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Nomor Keamanan',
            labelStyle: const TextStyle(color: AppColors.greyColor),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.greyColor, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.secondaryColor, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // profileCubit.updatePhoneSecurity(phoneController.text);
                  },
                  child: Text(
                    "Simpan",
                    style: AppTextStyles.textProfileBold,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
