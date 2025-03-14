part of '../view/iuran_page.dart';

void _customPaymentSection(BuildContext context, List<Data> selected) {
  final iuranCubit = context.read<IuranCubit>();
  iuranCubit.emit(iuranCubit.state.copyWith(selectedInvoices: selected));

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
          final adminFee = dialogContext.watch<IuranCubit>().state.adminFee;
          final totalAmount =
              selected.fold(0, (sum, item) => sum + (item.totalAmount ?? 0)) +
                  adminFee;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Metode Pembayaran",
                        style: AppTextStyles.textProfileBold
                            .copyWith(color: AppColors.blackColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        dialogContext
                            .read<IuranCubit>()
                            .getPaymentChannel(dialogContext);
                      },
                      splashColor: Colors.grey.withValues(alpha: 0.3),
                      highlightColor: Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: Text(
                          dialogContext.watch<IuranCubit>().state.channel ==
                                  null
                              ? "Pilih Pembayaran"
                              : "Ganti Pembayaran",
                          style: TextStyle(
                            color: dialogContext
                                        .watch<IuranCubit>()
                                        .state
                                        .channel ==
                                    null
                                ? AppColors.secondaryColor
                                : AppColors.redColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                _buildDetailRow("Keterangan", selected.first.note.toString()),
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
                  "Harga Iuran",
                  "${Price.currency(selected.fold(0, (sum, item) => sum + (item.totalAmount ?? 0)))}",
                  isBold: true,
                ),
                _buildDetailRow(
                  "Biaya Admin Bank",
                  "${Price.currency(adminFee)}",
                  isBold: true,
                ),
                _buildDetailRow(
                  "Total Pembayaran",
                  "${Price.currency(totalAmount)}",
                  isBold: true,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<IuranCubit, IuranState>(
                    builder: (context, state) {
                      return CustomButton(
                        text: state.isLoading ? "" : "Bayar",
                        onPressed: state.isLoading || state.channel == null
                            ? null
                            : () async {
                                final cubit = context.read<IuranCubit>();
                                try {
                                  var paymentNumber =
                                      await cubit.checkoutItem();
                                  if (context.mounted) {
                                    WaitingPaymentRoute(id: paymentNumber)
                                        .go(context);
                                  }
                                } catch (e) {
                                  ShowSnackbar.snackbar(context, e.toString(),
                                      '', AppColors.redColor);
                                }
                              },
                        child: state.isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      );
                    },
                  ),
                ),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 4,
          child: Text(
            title,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
        Flexible(
          flex: 7,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
            textAlign: TextAlign.right,
            softWrap: true,
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
