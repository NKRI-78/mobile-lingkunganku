import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/price_currency.dart';

import '../../../misc/colors.dart';
import '../../../misc/date_helper.dart';
import '../../../misc/text_style.dart';
import '../../../repositories/profile_repository/models/contribute_model.dart';

class ListDetailIuranSection extends StatelessWidget {
  const ListDetailIuranSection({super.key, required this.contribute});

  final Contributions contribute;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      padding: const EdgeInsets.all(12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                contribute.translateStatus,
                style: AppTextStyles.textStyle1.copyWith(fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                DateHelper.getMonthYear(contribute.invoiceDate.toString()),
                style: AppTextStyles.textStyle2.copyWith(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tanggal Bayar : ${DateHelper.parseDate(contribute.paidDate.toString())}",
                style: AppTextStyles.textWelcome.copyWith(fontSize: 10),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${Price.currency(contribute.totalAmount?.toDouble() ?? 0) ?? 0}',
                style: AppTextStyles.textStyle2.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Text(
            "Keterangan : ${contribute.note.toString()}",
            style: AppTextStyles.textWelcome.copyWith(fontSize: 10),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
