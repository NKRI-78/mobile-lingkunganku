import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../misc/colors.dart';
import '../../../../misc/date_helper.dart';
import '../../../../misc/text_style.dart';
import '../../../../widgets/button/custom_button.dart';
import '../../cubit/notification_cubit.dart';

class NotificationSosDetailPage extends StatelessWidget {
  const NotificationSosDetailPage({super.key, required this.idNotif});
  final int idNotif;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: NotificationCubit()..fetchDetailNotif(idNotif),
      child: NotificationSosDetailView(idNotif: idNotif),
    );
  }
}

class NotificationSosDetailView extends StatelessWidget {
  const NotificationSosDetailView({super.key, required this.idNotif});

  final int idNotif;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            elevation: 2,
            shadowColor: Colors.black.withOpacity(0.3),
            title: Text("Notification Detail", style: AppTextStyles.textStyle1),
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
          body: state.detail == null
              ? _buildShimmerEffect()
              : _buildNotificationContent(context, state),
        );
      },
    );
  }

  // Widget Shimmer Effect
  Widget _buildShimmerEffect() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white,
            child: Container(
              width: double.infinity,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white,
            child: Container(
              width: 200,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white,
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Konten Notifikasi
  Widget _buildNotificationContent(
      BuildContext context, NotificationState state) {
    bool isSosOrGivenRoleOrPaymentOrBroadcastOrInvoices =
        state.detail?.type == 'SOS' ||
            state.detail?.type == 'GIVEN_ROLE' ||
            state.detail?.type == 'PAYMENT' ||
            state.detail?.type == 'BROADCAST' ||
            state.detail?.type == 'INVOICES';
    return Column(
      children: [
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CustomScrollView(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.detail?.data?.title ?? "-",
                              style: AppTextStyles.textDialog.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(
                                  Icons.date_range,
                                  color: AppColors.greyColor,
                                  size: 18,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  DateHelper.getFormatedDateWithHours(
                                      state.detail?.createdAt ??
                                          DateTime.now().toString()),
                                  style: AppTextStyles.textDialog.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            const Divider(
                              height: 30,
                              color: AppColors.greyColor,
                            ),
                            Text(
                              isSosOrGivenRoleOrPaymentOrBroadcastOrInvoices
                                  ? state.detail?.data?.message ?? "-"
                                  : state.detail?.data?.body ?? "-",
                              style: AppTextStyles.textDialog,
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
              state.detail?.type == 'SOS'
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        child: SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            text: "Lihat Lokasi",
                            onPressed: () {
                              openLink(
                                  "https://www.google.com/maps/place/${state.detail?.data?.latitude},${state.detail?.data?.longitude}");
                            },
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}

// Fungsi untuk membuka Google Maps
Future<void> openLink(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $uri');
  }
}
