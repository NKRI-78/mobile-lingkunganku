part of '../view/iuran_page.dart';

void _customPaymentSection(BuildContext context, List<Data> selected) {
  final iuranCubit = context.read<IuranCubit>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return BlocProvider.value(
        value: iuranCubit,
        child: Builder(builder: (dialogContext) {
          final selectedChannel =
              dialogContext.watch<IuranCubit>().state.channel;
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Metode Pembayaran",
                      style: AppTextStyles.textProfileBold
                          .copyWith(color: AppColors.blackColor),
                    ),
                    TextButton(
                      onPressed: () {
                        debugPrint(
                            "Cubit diakses: ${dialogContext.read<IuranCubit>()}");
                        dialogContext
                            .read<IuranCubit>()
                            .getPaymentChannel(dialogContext);
                      },
                      child: Text(
                        "Pilih Pembayaran",
                        style: TextStyle(color: AppColors.secondaryColor),
                      ),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Detail Transaksi",
                    style: AppTextStyles.textProfileBold
                        .copyWith(color: AppColors.blackColor),
                  ),
                ),
                SizedBox(height: 5),
                _buildDetailRow(
                    "Pembayaran Untuk", selected.first.note.toString()),
                _buildDetailRow(
                    "Tanggal Iuran",
                    selected
                        .map((e) =>
                            DateHelper.parseDate(e.invoiceDate.toString()))
                        .toSet()
                        .join(", ")),
                _buildDetailRowWithImage(
                  "Pembayaran Dengan",
                  selectedChannel?.logo ?? "",
                  selectedChannel?.name ?? " _ ",
                ),
                Divider(),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Harus Dibayar",
                    style: AppTextStyles.textProfileBold
                        .copyWith(color: AppColors.blackColor),
                  ),
                ),
                _buildDetailRow(
                  "Total",
                  "Rp ${selected.fold(0, (sum, item) => sum + (item.totalAmount ?? 0))}",
                  isBold: true,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: "Bayar",
                    onPressed: (selectedChannel != null &&
                            selectedChannel.logo != null &&
                            selectedChannel.logo!.isNotEmpty)
                        ? () {
                            //
                          }
                        : null,
                  ),
                )
              ],
            ),
          );
        }),
      );
    },
  );
}

// Fungsi untuk membangun baris detail transaksi
Widget _buildDetailRow(String title, String value, {bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
        Text(
          value,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

// Fungsi untuk membangun baris detail transaksi dengan gambar (untuk bank)
Widget _buildDetailRowWithImage(
    String title, String? imageUrl, String? bankName) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
      imageUrl != null && imageUrl.isNotEmpty
          ? Image.network(
              imageUrl,
              height: 40,
            )
          : Text(
              bankName != null && bankName.isNotEmpty
                  ? bankName
                  : "Metode pembayaran belum dipilih",
              style: const TextStyle(
                  fontSize: 14, fontStyle: FontStyle.italic, color: Colors.red),
            ),
    ],
  );
}
