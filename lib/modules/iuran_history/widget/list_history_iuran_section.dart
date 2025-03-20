import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../misc/date_helper.dart';
import '../../../misc/price_currency.dart';
import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../repositories/iuran_repository/models/iuran_paid_model.dart';

class ListHistoryIuranSection extends StatelessWidget {
  final IuranPaidModel iuran;

  const ListHistoryIuranSection({super.key, required this.iuran});

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
                  "Tagihan Iuran",
                  style: AppTextStyles.textStyle1.copyWith(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10),
                Text(
                  "Bulan : ${DateHelper.getMonthYear(DateFormat('yyyy-MM-dd').format(iuran.invoiceDate))}",
                  style: AppTextStyles.textDialog,
                ),
                SizedBox(height: 10),
                Text(
                  "Keterangan : ${iuran.note}",
                  style: AppTextStyles.textDialog,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  Price.currency(iuran.totalAmount.toDouble()),
                  style: AppTextStyles.textStyle2
                      .copyWith(color: AppColors.blackColor),
                ),
                const SizedBox(height: 20),
                Chip(
                  label: Text(
                    iuran.translateStatus,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: iuran.translateStatus == "Sudah Bayar"
                      ? AppColors.secondaryColor
                      : iuran.translateStatus == "Belum Bayar"
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
