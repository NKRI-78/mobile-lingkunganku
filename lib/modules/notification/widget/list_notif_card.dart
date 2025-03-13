import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../router/builder.dart';
import '../../../misc/price_currency.dart';
import '../cubit/notification_cubit.dart';

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
        await context.read<NotificationCubit>().readNotif(notif.id.toString());
        if (notif.type.contains("PAYMENT")) {
          WaitingPaymentRoute(id: notif.paymentId.toString()).push(context);
        }
        // if (notif.type.contains("SOS")) {
        //   NotificationSosRoute(id: notif.paymentId.toString()).push(context);
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
                    notif.title,
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
                        DateHelper.parseDate(notif.createdAt.toString()),
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
              thickness: .5,
              color: AppColors.greyColor,
            ),
            Text(
              notif.message,
              style: const TextStyle(
                color: AppColors.blackColor,
                fontSize: 13,
              ),
            ),

            // Hanya tampilkan jika tipe notifikasi PAYMENT
            if (notif.type.contains("PAYMENT")) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      'Total Pembayaran',
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${Price.currency(notif.totalPrice?.toDouble() ?? 0) ?? 0}',
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
            ]
          ],
        ),
      ),
    );
  }
}
