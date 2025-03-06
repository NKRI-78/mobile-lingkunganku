import 'package:flutter/material.dart';

import '../../../misc/colors.dart';
import '../../../misc/date_helper.dart';
import '../../../repositories/notification_repository/models/notification_model.dart';

class ListNotifCard extends StatelessWidget {
  const ListNotifCard({super.key, required this.notif});

  final NotificationModel notif;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // await context.read<NotificationCubit>().readNotif(notif.id.toString());
        // if (context.mounted) {
        //   WaitingPaymentRoute(id: notif.data?.paymentId.toString() ?? "0")
        //       .push(context);
        // }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            color: notif.readAt == null
                ? AppColors.greyColor.withOpacity(0.2)
                : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.blackColor.withOpacity(0.2))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    '${notif.data?.title}',
                    style: const TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        DateHelper.parseDate(notif.createdAt ?? ""),
                        style: const TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: .3,
              color: AppColors.blackColor,
            ),
          ],
        ),
      ),
    );
  }
}
