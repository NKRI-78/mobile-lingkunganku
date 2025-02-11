part of 'management_acces_section.dart';

void _showManagementAccesDialog(BuildContext context) {
  String? selectedRole;
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
                const Text(
                  "Pilih Jenis Kepengurusan",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Column(
                  children: [
                    RadioListTile<String>(
                      title: const Text("Wakil Ketua"),
                      value: "Wakil Ketua",
                      groupValue: selectedRole,
                      onChanged: (value) {
                        setState(() => selectedRole = value);
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text("Bendahara"),
                      value: "Bendahara",
                      groupValue: selectedRole,
                      onChanged: (value) {
                        setState(() => selectedRole = value);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedRole != null) {
                        Navigator.pop(context, selectedRole);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      "Yakin",
                      style: TextStyle(color: Colors.white),
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
