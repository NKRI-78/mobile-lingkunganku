part of 'member_list_section.dart';

void _showPeringatanDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/ic-alert.png',
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 10),
            const Text(
              "Peringatan",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Anda adalah Ketua Lingkungan. Jika ingin mengalihkan jabatan kepada anggota lain, silakan pilih warga yang tersedia.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Center(
                child: Text(
              "Mengerti",
              style:
                  AppTextStyles.textDialog.copyWith(color: AppColors.redColor),
            )),
          ),
        ],
      );
    },
  );
}
