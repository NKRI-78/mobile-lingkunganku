part of 'management_acces_section.dart';

void _showManagementAccesDialog(
    BuildContext context, String? currentRole, String userId) {
  String? selectedRole = currentRole;

  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocProvider.value(
          value: context.read<ManagementDetailCubit>(),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            content: StatefulBuilder(
              builder: (BuildContext dialogContext, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.close, color: AppColors.greyColor),
                        onPressed: () => Navigator.pop(dialogContext),
                      ),
                    ),
                    Text(
                      "Pilih Jenis Kepengurusan",
                      style: AppTextStyles.textDialog,
                    ),
                    Column(
                      children: [
                        RadioListTile<String>(
                          title: const Text("Sekretaris"),
                          value: "Sekretaris",
                          groupValue: selectedRole,
                          activeColor: AppColors.secondaryColor,
                          onChanged: (value) {
                            setState(() {
                              selectedRole = value;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text("Bendahara"),
                          value: "Bendahara",
                          groupValue: selectedRole,
                          activeColor: AppColors.secondaryColor,
                          onChanged: (value) {
                            setState(() {
                              selectedRole = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (selectedRole != null) {
                            Navigator.pop(dialogContext, selectedRole);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          "Yakin",
                          style: AppTextStyles.textProfileBold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    ).then((selectedRole) async {
      if (selectedRole != null) {
        try {
          final cubit = context.read<ManagementDetailCubit>();

          if (selectedRole == "Sekretaris") {
            await cubit.updateToSecretary(userId);
          } else if (selectedRole == "Bendahara") {
            await cubit.updateToTreasure(userId);
          }

          // Fetch ulang data agar roleApp diperbarui
          await cubit.fetchManagementDetailMembers(userId: userId);
        } catch (e) {
          print("Error: Gagal memperbarui status kepengurusan - $e");
        }
      }
    });
  });
}
