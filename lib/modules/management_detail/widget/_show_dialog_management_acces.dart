part of 'management_acces_section.dart';

void _showManagementAccesDialog(
    BuildContext context, String? currentRole, String userId) {
  print("Memanggil showDialog...");
  String? selectedRole = currentRole;
  print("userId $userId");

  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
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
                      onPressed: () {
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
        );
      },
    ).then((selectedRole) {
      if (selectedRole == "Sekretaris") {
        context.read<ManagementDetailCubit>().updateToSecretary(userId);
      } else if (selectedRole == "Bendahara") {
        context.read<ManagementDetailCubit>().updateToTreasure(userId);
      }
    });
  });
}
