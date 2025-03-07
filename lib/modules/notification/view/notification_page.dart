import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/modules/notification/cubit/notification_cubit.dart';
import 'package:mobile_lingkunganku/widgets/header/header_text.dart';
import 'package:mobile_lingkunganku/widgets/pages/empty_page.dart';
import 'package:mobile_lingkunganku/widgets/pages/loading_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../widget/list_notif_card.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<NotificationCubit>()..fetchNotification(),
      child: NotificationView(),
    );
  }
}

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          return SmartRefresher(
            controller: NotificationCubit.refreshCtrl,
            onRefresh: () {
              context.read<NotificationCubit>().fetchNotification();
            },
            enablePullUp: (state.pagination?.currentPage ?? 0) >=
                    (state.pagination?.totalPages ?? 0)
                ? false
                : true,
            enablePullDown: true,
            onLoading: () async {
              context.read<NotificationCubit>().loadMoreNotification();
            },
            child: CustomScrollView(
              slivers: [
                HeaderText(text: 'Notification'),
                state.loading
                    ? const SliverFillRemaining(
                        child: Center(child: LoadingPage()),
                      )
                    : state.notif.isEmpty
                        ? const SliverFillRemaining(
                            child: Center(
                                child: EmptyPage(msg: "Belum ada notifikasi")))
                        : SliverList(
                            delegate: SliverChildListDelegate([
                            ListView(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                children: state.notif
                                    .map((e) => ListNotifCard(
                                          notif: e,
                                        ))
                                    .toList())
                          ]))
              ],
            ),
          );
        },
      ),
    );
  }
}
