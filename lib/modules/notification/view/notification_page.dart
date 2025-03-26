import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/modules/notification/widget/notification_list.dart';
import 'package:mobile_lingkunganku/modules/notification/widget/notification_list_ppob.dart';

import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../misc/text_style.dart';
import '../cubit/notification_cubit.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<NotificationCubit>()..fetchNotification(),
      child: const NotificationView(),
    );
  }
}

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        int unreadPPOB =
            state.inboxNotif.where((n) => n.isRead == false).length;

        int unreadSOS = state.notif
            .where((n) => n.type == "SOS" && n.readAt == null)
            .length;
        int unreadPayment = state.notif
            .where((n) => n.type.contains("PAYMENT") && n.readAt == null)
            .length;
        int unreadOther = state.notif
            .where((n) =>
                n.type != "SOS" &&
                !n.type.contains("PAYMENT") &&
                n.readAt == null)
            .length;

        return DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              elevation: 2,
              shadowColor: Colors.black.withOpacity(0.1),
              title: Text("Notifikasi", style: AppTextStyles.textStyle1),
              centerTitle: true,
              toolbarHeight: 80,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.buttonColor2,
                  size: 24,
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              bottom: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorColor: AppColors.secondaryColor,
                labelColor: AppColors.secondaryColor,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  _buildTabWithBadge("SOS", unreadSOS),
                  _buildTabWithBadge("TRANSAKSI", unreadPayment),
                  _buildTabWithBadge("PULSA DAN TAGIHAN", unreadPPOB),
                  _buildTabWithBadge("OTHER", unreadOther),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                NotificationList(category: "SOS"),
                NotificationList(category: "PAYMENT"),
                NotificationListPpob(),
                NotificationList(category: "OTHER"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabWithBadge(String title, int unreadCount) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Tab(text: title),
        if (unreadCount > 0)
          Positioned(
            right: -15,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 10,
                minHeight: 10,
              ),
              child: Text(
                unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
