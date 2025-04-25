import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../misc/colors.dart';
import '../../../widgets/pages/empty_page.dart';
import '../../../widgets/pages/loading_page.dart';
import '../cubit/notification_cubit.dart';
import 'list/list_notif_card_ppob.dart';

class NotificationListPpob extends StatelessWidget {
  const NotificationListPpob({super.key});

  @override
  Widget build(BuildContext context) {
    final RefreshController refreshController = RefreshController();

    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        return SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          onRefresh: () async {
            await context.read<NotificationCubit>().fetchInboxNotifications();
            refreshController.refreshCompleted();
          },
          header: const MaterialClassicHeader(
            color: AppColors.secondaryColor,
          ),
          child: CustomScrollView(
            slivers: [
              state.loading
                  ? const SliverFillRemaining(
                      child: Center(child: LoadingPage()),
                    )
                  : state.inboxNotif.isEmpty
                      ? const SliverFillRemaining(
                          child: EmptyPage(msg: "Tidak ada notifikasi"),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final notif =
                                  state.inboxNotif.reversed.toList()[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: ListNotifCardPpob(
                                  notifv2: notif,
                                  idNotif: notif.id ?? 0,
                                ),
                              );
                            },
                            childCount: state.inboxNotif.length,
                          ),
                        ),
            ],
          ),
        );
      },
    );
  }
}
