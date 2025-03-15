import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../repositories/iuran_repository/models/iuran_paid_model.dart';

class ListHistoryIuranSection extends StatelessWidget {
  final IuranPaidModel iuran;

  const ListHistoryIuranSection({super.key, required this.iuran});

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Detail History Iuran
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  iuran.name,
                  style: AppTextStyles.textStyle1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  "No. Invoice: ${iuran.invoiceNumber}",
                  style: AppTextStyles.textStyle2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  "Tanggal: ${formatDate(iuran.invoiceDate)}",
                  style: AppTextStyles.textWelcome,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Rp ${iuran.totalAmount}",
                  style: AppTextStyles.textStyle1.copyWith(color: Colors.green),
                ),
                const SizedBox(height: 5),
                Chip(
                  label: Text(
                    iuran.translateStatus,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: iuran.translateStatus == "Sudah Bayar"
                      ? Colors.green
                      : iuran.translateStatus == "Belum Bayar"
                          ? Colors.red
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
