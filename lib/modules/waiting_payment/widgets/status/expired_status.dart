import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../misc/colors.dart';
import '../../../../misc/price_currency.dart';
import '../../cubit/waiting_payment_cubit.dart';

class ExpiredStatus extends StatelessWidget {
  const ExpiredStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaitingPaymentCubit, WaitingPaymentState>(
      builder: (context, state) {
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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Pembayaran Gagal",
                    style: TextStyle(
                      color: AppColors.redColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
