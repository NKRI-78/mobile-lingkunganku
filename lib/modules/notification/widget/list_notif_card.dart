import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/router/builder.dart';
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
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            color: notif.readAt == null
                ? AppColors.greyColor.withValues(alpha: 0.2)
                : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: AppColors.blackColor.withValues(alpha: 0.2))),
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
              thickness: .3,
              color: AppColors.blackColor,
            ),
            Text(
              notif.message,
              style: const TextStyle(
                color: AppColors.blackColor,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
