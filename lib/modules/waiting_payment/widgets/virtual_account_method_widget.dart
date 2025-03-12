import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../misc/colors.dart';
import '../../../misc/snackbar.dart';
import '../../../repositories/payment_repository/models/payment_model.dart';

class VirtualAccountMethodWidget extends StatelessWidget {
  const VirtualAccountMethodWidget({super.key, required this.payment});

  final PaymentModel payment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        const Text(
          "Nomor Virtual Account",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                payment.data?['vaNumber'] ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                try {
                  await Clipboard.setData(
                      ClipboardData(text: payment.data?['vaNumber'] ?? ''));
                  if (context.mounted) {
                    ShowSnackbar.snackbar(context, "Berhasil menyalin nomor VA",
                        '', AppColors.secondaryColor);
                  }
                } catch (e) {
                  ///
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
        const SizedBox(
          height: 8,
        ),
        const Text(
          "Biaya",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'Rp ${NumberFormat('#,##0.00', 'ID').format(payment.price ?? 0)}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          "Biaya Layanan",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'Rp ${NumberFormat('#,##0.00', 'ID').format(int.parse(payment.fee.toString()))}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          "Total Pembayaran",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                'Rp ${NumberFormat('#,##0.00', 'ID').format(payment.totalPrice ?? 0)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                try {
                  await Clipboard.setData(
                      ClipboardData(text: payment.price?.toString() ?? '0'));
                  if (context.mounted) {
                    ShowSnackbar.snackbar(
                        context,
                        'Berhasil menyalin total pembayaran',
                        '',
                        AppColors.secondaryColor);
                  }
                } catch (e) {
                  ///
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
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColors.secondaryColor.withOpacity(.3),
              border: Border.all(
                color: AppColors.secondaryColor,
              ),
              borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: const Row(
            children: [
              Icon(
                Icons.info,
                color: AppColors.secondaryColor,
                size: 35,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Text(
                    'Tidak disarankan transfer Virtual Account dari bank selain yang dipilih.'),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
