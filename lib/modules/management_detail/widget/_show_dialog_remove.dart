part of 'remove_user_section.dart';

void _showRemoveManagementMemberDialog(
    BuildContext context, MemberData member) {
  // Cek apakah user memiliki keluarga
  final hasFamilies = member.families != null && member.families!.isNotEmpty;

  // Jika ada keluarga, tampilkan semua nama
  final familyMemberNames = hasFamilies
      ? member.families!
          .map((family) => family.profile?.fullname ?? "Nama Tidak Diketahui")
          .join(", ")
      : "Tidak ada anggota keluarga";

  // Ambil detail alamat dari profile
  final detailAddress =
      member.profile?.detailAddress ?? "Alamat Tidak Diketahui";

  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: const EdgeInsets.all(12),
        content: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icons/chat_bubble.png',
                  width: 150,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 10),
                Text(
                  "Apakah kamu yakin ingin menghapus ${member.profile?.fullname ?? "Nama Tidak Diketahui"} dari Lingkungan?",
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.textDialog,
                ),
                const SizedBox(height: 10),
                Text(
                  "Ini akan menghapus semua data keluarga berikut :\n$familyMemberNames",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.textDialog,
                ),
                const SizedBox(height: 10),
                Text(
                  "Detail Alamat :\n$detailAddress",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.textDialog,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 120,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          final cubit = context.read<ManagementDetailCubit>();
                          cubit.removeMember(member.id.toString());

                          Navigator.of(dialogContext).pop();
                          ManagementRoute().go(context);
                        },
                        child:
                            Text("Yakin", style: AppTextStyles.textProfileBold),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child:
                            Text("Tidak", style: AppTextStyles.textProfileBold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: -10,
              right: -10,
              child: IconButton(
                icon: const Icon(Icons.close, color: AppColors.textColor),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
