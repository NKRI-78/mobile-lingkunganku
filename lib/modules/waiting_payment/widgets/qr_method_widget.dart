import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../misc/colors.dart';
import '../../../misc/price_currency.dart';
import '../../../misc/snackbar.dart';
import '../../../misc/theme.dart';
import '../../../repositories/payment_repository/models/payment_model.dart';
import '../../../widgets/image/image_card.dart';

// ignore: non_constant_identifier_names
GlobalKey QrDownload = GlobalKey();

class QrMethodWidget extends StatelessWidget {
  const QrMethodWidget({super.key, required this.payment});

  final PaymentModel payment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Biaya Pendaftaran",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Rp ${NumberFormat('#,##0', 'ID').format(payment.price ?? 0)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Biaya Layanan",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${Price.currency(payment.fee?.toDouble() ?? 0.0)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total Pembayaran",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rp ${NumberFormat('#,##0', 'ID').format(payment.totalPrice ?? 0)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    try {
                      await Clipboard.setData(ClipboardData(
                          text: payment.price?.toString() ?? '0'));
                      if (context.mounted) {
                        ShowSnackbar.snackbar(
                            context,
                            "Berhasil menyalin total pembayaran",
                            '',
                            AppColors.secondaryColor);
                      }
                    } catch (e) {
                      ///
                    }
                  },
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 6,
                      ),
                      Icon(
                        Icons.copy,
                        color: AppColors.secondaryColor,
                        size: 20,
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        RepaintBoundary(
          key: QrDownload,
          child: ImageCard(
            image: payment.data?["actions"][0]["url"] ?? "-",
            radius: 10,
            width: double.infinity,
            height: 300,
            imageError: imageDefault,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                  onPressed: () {
                    // DownloadHelper.downloadWidget(QrDownload, "${DateFormat('yyyyddMM').format(DateTime.now())}.png", context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.download,
                        size: 20,
                        color: AppColors.whiteColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Unduh Kode QR",
                        style: TextStyle(color: AppColors.whiteColor),
                      )
                    ],
                  )),
            ),
            payment.name == "Gopay"
                ? const Text(
                    "Atau Bayar Langsung di Aplikasi Gopay",
                    style: TextStyle(),
                  )
                : const SizedBox.shrink(),
            payment.name == "Gopay"
                ? SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          // Helper.openLink(url: payment.data?["actions"][1]["url"], context: context);
                        },
                        child: const Text("Bayar Dengan Gopay")),
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ],
    );
  }
}
