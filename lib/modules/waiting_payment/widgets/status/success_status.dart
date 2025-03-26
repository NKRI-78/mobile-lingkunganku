import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../misc/colors.dart';
import '../../../../misc/price_currency.dart';
import '../../cubit/waiting_payment_cubit.dart';

class SuccessStatus extends StatelessWidget {
  const SuccessStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaitingPaymentCubit, WaitingPaymentState>(
      builder: (context, state) {
        // double totalProduct = state.payment?.orders?.fold(0.0, (sum, order) {
        //       return sum! + ((order.price ?? 0));
        //     }) ??
        //     0;
        // double totalShipping = state.payment?.orders?.fold(0.0, (sum, order) {
        //       return sum! + ((order.otherPrice ?? 0));
        //     }) ??
        //     0;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: AppColors.blackColor.withOpacity(0.2))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Pembayaran Berhasil",
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: AppColors.blackColor.withOpacity(0.2))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/thumbs-up.png",
                    height: 150,
                  ),
                  const Text(
                      "Pembayaran Anda berhasil! Terima kasih telah melakukan pembayaran",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: AppColors.blackColor.withOpacity(0.2))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Rincian Pembayaran",
                      style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      thickness: .3,
                      color: AppColors.blackColor,
                    ),
                    state.payment?.paymentType != "TOPUP"
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Bulan Iuran",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Expanded(
                                  child: Text(
                                    state.payment?.invoices
                                            ?.map((invoice) =>
                                                DateFormat("MMMM yyyy", "id_ID")
                                                    .format(DateTime.parse(
                                                        invoice.invoiceDate
                                                            .toString())))
                                            .join(", ") ??
                                        "-",
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                      color: AppColors.blackColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.payment?.paymentType == "TOPUP"
                                ? "Harga Topup"
                                : "Harga Iuran",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            Price.currency(
                                state.payment!.price?.toDouble() ?? 0.0),
                            style: const TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Biaya Admin Bank",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            Price.currency(
                                state.payment?.fee?.toDouble() ?? 0.0),
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total Pembayaran",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            Price.currency(
                                state.payment?.totalPrice?.toDouble() ?? 0.0),
                            style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }
}
