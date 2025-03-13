import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/notification_cubit.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';

class NotificationSosDetailPage extends StatelessWidget {
  final String id;
  const NotificationSosDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: NotificationCubit()..fetchNotification(),
      child: NotificationSosDetailView(id: id),
    );
  }
}

class NotificationSosDetailView extends StatelessWidget {
  final String id;
  const NotificationSosDetailView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            elevation: 2,
            shadowColor: Colors.black.withOpacity(0.3),
            title: Text("SOS Detail", style: AppTextStyles.textStyle1),
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
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Judul: ${state.notif.first.title}",
                    style: AppTextStyles.textStyle1),
                const SizedBox(height: 10),
                Text("Deskripsi: ${state.notif.first.description}",
                    style: AppTextStyles.textStyle2),
                const SizedBox(height: 10),
                Text("Tanggal: ${state.notif.first.createdAt}",
                    style: AppTextStyles.textStyle2),
                const SizedBox(height: 10),
                Text("Status: ${state.notif.first.message}",
                    style: AppTextStyles.textStyle2),
              ],
            ),
          ),
        );
      },
    );
  }
}
