import 'package:flutter/material.dart';
import '../../../../router/builder.dart';
import '../../../../misc/colors.dart';
import '../../../../repositories/notification_repository/models/notificationv2_model.dart';

class ListNotifCardPpob extends StatelessWidget {
  const ListNotifCardPpob(
      {super.key, required this.notifv2, required this.idNotif});

  final NotificationV2Model notifv2;
  final int idNotif;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        NotificationPpobRoute(idNotif: idNotif).go(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: (notifv2.isRead == null || notifv2.isRead == false)
              ? AppColors.greyColor.withOpacity(0.2)
              : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.blackColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notifv2.title ?? "Tanpa Judul",
              style: const TextStyle(
                color: AppColors.blackColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              thickness: 0.5,
              color: AppColors.greyColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Status Pembayaran",
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  notifv2.translateStatus,
                  style: const TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
