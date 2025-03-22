part of '../view/ppob_page.dart';

void _customPaymentSection(BuildContext context, List<PulsaDataModel> selected,
    String phoneNumber, String type) {
  final ppobCubit = context.read<PpobCubit>();
  final String? productType = ppobCubit.currentType;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return BlocProvider.value(
        value: ppobCubit,
        child:
            BlocBuilder<PpobCubit, PpobState>(builder: (dialogContext, state) {
          final pulsaData = selected.first;
          final selectedChannel = state.channel;
          final double productPrice = pulsaData.price?.toDouble() ?? 0;
          final double totalAmount = productPrice + state.adminFee;

          String getProductTitle(String? type) {
            switch (type) {
              case "PULSA":
                return "Harga Pulsa";
              case "DATA":
                return "Harga Paket Data";
              default:
                return "Harga Produk";
            }
          }

          return Padding(
            padding: EdgeInsets.all(20),
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
                            .read<PpobCubit>()
                            .getPaymentChannel(dialogContext);
                      },
                      splashColor: Colors.grey.withValues(alpha: 0.3),
                      highlightColor: Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        child: Text(
                          dialogContext.watch<PpobCubit>().state.channel == null
                              ? "Pilih Pembayaran"
                              : "Ganti Pembayaran",
                          style: TextStyle(
                            color: dialogContext
                                        .watch<PpobCubit>()
                                        .state
                                        .channel ==
                                    null
                                ? AppColors.secondaryColor
                                : AppColors.redColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
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
                    "Pembayaran Untuk", selected.first.name.toString()),
                _buildDetailRow(
                  getProductTitle(productType),
                  "${Price.currency(productPrice)}",
                  isBold: true,
                ),
                _buildDetailRow(
                  "Biaya Admin Bank",
                  "${Price.currency(state.adminFee)}",
                  isBold: true,
                ),
                _buildDetailRowWithImage(
                    "Pembayaran Dengan",
                    selectedChannel?.logo ?? "",
                    selectedChannel?.name ?? " _ "),
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
                  "Total Pembayaran",
                  "${Price.currency(totalAmount)}",
                  isBold: true,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<PpobCubit, PpobState>(
                    builder: (context, state) {
                      final userId = getIt<AppBloc>().state.user?.id ?? 0;
                      return CustomButton(
                        text: state.isLoading ? "" : "Bayar",
                        onPressed: state.isLoading || state.channel == null
                            ? null
                            : () async {
                                final cubit = context.read<PpobCubit>();
                                try {
                                  await cubit.checkoutItem(
                                      userId.toString(), type, phoneNumber);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PpobWaitingPaymentPage(),
                                    ),
                                  );
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
