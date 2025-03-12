import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../misc/colors.dart';
import '../../../../misc/snackbar.dart';
import '../../../../misc/theme.dart';
import '../../../../repositories/payment_repository/models/payment_model.dart';
import '../../../../widgets/image/image_card.dart';

class VirtualAccountMethodWidgetv2 extends StatelessWidget {
  const VirtualAccountMethodWidgetv2({super.key, required this.payment});

  final PaymentModel payment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.blackColor.withOpacity(0.2))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  payment.name ?? "-",
                  style: const TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ImageCard(
                  image: payment.logoUrl ?? "-",
                  radius: 0,
                  width: 45,
                  height: 45,
                  imageError: imageDefault,
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors.greyColor.withOpacity(0.5),
            thickness: 2,
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nomor Virtual Account',
                      style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      payment.data?['vaNumber'] ?? '',
                      style: const TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    try {
                      await Clipboard.setData(
                          ClipboardData(text: payment.data?['vaNumber'] ?? ''));
                      if (context.mounted) {
                        ShowSnackbar.snackbar(
                            context,
                            "Berhasil menyalin nomor VA",
                            '',
                            AppColors.secondaryColor);
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ShowSnackbar.snackbar(context, "Gagal menyalin $e", '',
                            AppColors.redColor);
                      }
                    }
                  },
                  child: const Row(
                    children: [
                      Text(
                        'Salin',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Icon(
                        Icons.copy,
                        color: AppColors.secondaryColor,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
