import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../misc/text_style.dart';
import '../cubit/notification_cubit.dart';
import '../../../widgets/pages/empty_page.dart';
import '../../../widgets/pages/loading_page.dart';
import '../widget/list_notif_card.dart';

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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.3),
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
          bottom: const TabBar(
            indicatorColor: AppColors.secondaryColor,
            labelColor: AppColors.secondaryColor,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "SOS"),
              Tab(text: "PAYMENT"),
              Tab(text: "OTHER"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NotificationList(category: "SOS"),
            NotificationList(category: "PAYMENT"),
            NotificationList(category: "OTHER"),
          ],
        ),
      ),
    );
  }
}

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
                                  .map((e) => ListNotifCard(notif: e))
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
