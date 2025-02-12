part of 'management_acces_section.dart';

void _showManagementAccesDialog(BuildContext context, String? currentRole) {
  String? selectedRole = currentRole;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: AppColors.greyColor),
                    onPressed: () => Navigator.pop(context),
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
                      print("Select : $selectedRole");
                      if (selectedRole != null) {
                        Navigator.pop(context, selectedRole);
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
  );
}
