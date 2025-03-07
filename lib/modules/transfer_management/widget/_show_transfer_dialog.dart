part of 'member_list_section.dart';

void _showTransferDialog(BuildContext context, String userId, String name) {
  final cubit = context.read<TransferManagementCubit>();

  showDialog(
    context: context,
    builder: (dialogContext) {
      return BlocProvider.value(
        value: cubit,
        child: BlocListener<TransferManagementCubit, TransferManagementState>(
          listener: (dialogContext, state) {
            if (!state.isLoading && state.errorMessage == null) {
              Navigator.of(dialogContext).pop();
              Navigator.of(dialogContext).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Berhasil mengubah Ketua Lingkungan!")),
              );
            } else if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: EdgeInsets.all(12),
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
                      "Apakah kamu yakin ingin alihkan Ketua Lingkungan yang baru ke $name ?",
                      maxLines: 3,
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
                              cubit.updateToChief(userId);
                            },
                            child: BlocBuilder<TransferManagementCubit,
                                TransferManagementState>(
                              builder: (context, state) {
                                return state.isLoading
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text("Yakin",
                                        style: AppTextStyles.textProfileBold);
                              },
                            ),
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
                            child: Text("Tidak\nYakin",
                                style: AppTextStyles.textProfileBold),
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
          ),
        ),
      );
    },
  );
}
