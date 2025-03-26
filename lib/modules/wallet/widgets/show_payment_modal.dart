import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../../../misc/price_currency.dart';
import '../../../misc/snackbar.dart';
import '../../../misc/text_style.dart';
import '../../../router/builder.dart';
import '../../../widgets/button/custom_button.dart';
import '../cubit/wallet_cubit.dart';

void showPaymentModal(BuildContext context) {
  final walletCubit = context.read<WalletCubit>();
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return BlocProvider.value(
        value: walletCubit,
        child: BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
          final selectedChannel = state.channel;
          final adminFee = state.adminFee;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        context.read<WalletCubit>().getPaymentChannel(context);
                      },
                      splashColor: Colors.grey.withValues(alpha: 0.3),
                      highlightColor: Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: Text(
                          context.watch<WalletCubit>().state.channel == null
                              ? "Pilih Pembayaran"
                              : "Ganti Pembayaran",
                          style: TextStyle(
                            color: context.watch<WalletCubit>().state.channel ==
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
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Detail Transaksi",
                    style: AppTextStyles.textProfileBold
                        .copyWith(color: AppColors.blackColor),
                  ),
                ),
                _buildDetailRow(
                  "Topup Saldo",
                  "${Price.currency(state.amount)}",
                  isBold: true,
                ),
                _buildDetailRow(
                  "Biaya Admin Bank",
                  "${Price.currency(adminFee)}",
                  isBold: true,
                ),
                SizedBox(height: 5),
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
                  "Total Pembayaran",
                  "${Price.currency(state.totalAmount)}",
                  isBold: true,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<WalletCubit, WalletState>(
                    builder: (context, state) {
                      return CustomButton(
                        text: state.isLoading ? "" : "Bayar",
                        onPressed: state.isLoading || state.channel == null
                            ? null
                            : () async {
                                var cubit = context.read<WalletCubit>();
                                try {
                                  var paymentNumber =
                                      await cubit.topUpWallet(context);
                                  if (context.mounted) {
                                    WaitingPaymentRoute(
                                            id: paymentNumber.toString())
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
