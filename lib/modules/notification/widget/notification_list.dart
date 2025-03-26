import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../misc/colors.dart';
import '../../../widgets/pages/empty_page.dart';
import '../../../widgets/pages/loading_page.dart';
import '../cubit/notification_cubit.dart';
import 'list/list_notif_card.dart';

class NotificationList extends StatefulWidget {
  final String category;
  const NotificationList({super.key, required this.category});

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        final notifications = state.notif.where((n) {
          if (widget.category == "SOS") return n.type == "SOS";
          if (widget.category == "PAYMENT") return n.type.contains("PAYMENT");
          return n.type != "SOS" && !n.type.contains("PAYMENT");
        }).toList();

        return SmartRefresher(
          controller: _refreshController,
          onRefresh: () async {
            await context.read<NotificationCubit>().refreshNotification();
            _refreshController.refreshCompleted();
          },
          enablePullUp: (state.pagination?.currentPage ?? 0) <
              (state.pagination?.totalPages ?? 0),
          enablePullDown: true,
          onLoading: () async {
            await context.read<NotificationCubit>().loadMoreNotification();
            _refreshController.loadComplete();
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
                  : notifications.isEmpty
                      ? const SliverFillRemaining(
                          child: Center(
                              child: EmptyPage(msg: "Tidak ada notifikasi")),
                        )
                      : SliverList(
                          delegate: SliverChildListDelegate([
                            ListView(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: notifications
                                  .map((e) => ListNotifCard(
                                        notif: e,
                                      ))
                                  .toList(),
                            )
                          ]),
                        ),
            ],
          ),
        );
      },
    );
  }
}
