import 'package:flutter/material.dart';
import '../../../misc/date_helper.dart';
import '../../../misc/price_currency.dart';
import '../../../repositories/profile_repository/models/contribute_model.dart';
import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';

class ListIuranInfoSection extends StatelessWidget {
  final Contributions contribute;

  const ListIuranInfoSection({super.key, required this.contribute});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigasi ke detail history iuran jika diperlukan
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Bagian Kiri (Informasi Iuran)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tagihan Iuran",
                    style: AppTextStyles.textStyle1.copyWith(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Nama : ${contribute.user?.profile?.fullname ?? '-'}",
                    style: AppTextStyles.textDialog,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Bulan : ${DateHelper.getMonthYear(contribute.invoiceDate)}",
                    style: AppTextStyles.textDialog,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),

            /// Bagian Kanan (Jumlah & Status Pembayaran)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  Price.currency(contribute.totalAmount.toDouble()),
                  style: AppTextStyles.textStyle2
                      .copyWith(color: AppColors.blackColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 30),
                Chip(
                  label: Text(
                    contribute.translateStatus,
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  backgroundColor: contribute.translateStatus == "Sudah Bayar"
                      ? AppColors.secondaryColor
                      : contribute.translateStatus == "Belum Bayar"
                          ? AppColors.redColor
                          : Colors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
