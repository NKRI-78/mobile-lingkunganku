import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/modules/notification/cubit/notification_cubit.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../../misc/colors.dart';
import '../../../../misc/snackbar.dart';
import '../../../../misc/text_style.dart';

class NotificationPpobDetailPage extends StatelessWidget {
  const NotificationPpobDetailPage({super.key, required this.idNotif});

  final int idNotif;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<NotificationCubit>()..fetchDetailInboxNotifications(idNotif),
      child: NotificationPpobDetailView(),
    );
  }
}

class NotificationPpobDetailView extends StatefulWidget {
  const NotificationPpobDetailView({super.key});

  @override
  State<NotificationPpobDetailView> createState() =>
      _NotificationPpobDetailViewState();
}

class _NotificationPpobDetailViewState
    extends State<NotificationPpobDetailView> {
  bool isExpired = false; // Tambahkan state ini

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            title: Text("Pembayaran", style: AppTextStyles.textStyle1),
            centerTitle: true,
            toolbarHeight: 80,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.buttonColor2,
                size: 24,
              ),
              onPressed: () {
                GoRouter.of(context).pop();
              },
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Timer box akan mengupdate `isExpired`
                _buildTimerBox(state.detailv2?.field5, state.detailv2?.field2,
                    (expired) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() {
                        isExpired = expired;
                      });
                    }
                  });
                }),

                // Hanya tampilkan jika belum expired dan belum dibayar
                if (!isExpired && state.detailv2?.field2 != "PAID")
                  _buildPaymentBox(
                    context,
                    state.detailv2?.field4 ?? "-",
                    state.channel?.logo ?? "-",
                    state.detailv2?.link ?? "-",
                  ),

                _buildDetailPayment(
                  context,
                  state.detailv2?.title ?? "-",
                  state.detailv2?.description ?? "-",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildTimerBox(String? expiredDate, String? paymentStatus,
    Function(bool) onExpiredStatusChanged) {
  if (expiredDate == null || expiredDate.isEmpty) {
    onExpiredStatusChanged(true);
    return Center(child: Text("Tanggal kadaluarsa tidak valid"));
  }

  try {
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime paymentExpired = format.parseStrict(expiredDate);
    Duration duration = paymentExpired.difference(DateTime.now());
    bool isExpired = duration.isNegative;

    // Periksa status pembayaran
    bool isPaid = paymentStatus == "PAID";

    // Perbarui status expired di parent hanya jika belum dibayar
    if (!isPaid) {
      onExpiredStatusChanged(isExpired);
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.blackColor.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isPaid
                    ? "Pembayaran Berhasil"
                    : (isExpired
                        ? "Pembayaran Gagal"
                        : "Batas Akhir Pembayaran"),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isPaid
                      ? AppColors.secondaryColor
                      : (isExpired ? AppColors.redColor : AppColors.blackColor),
                ),
              ),
              if (!isExpired && !isPaid)
                Text(
                  DateFormat('dd MMM yyyy HH:mm').format(paymentExpired),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
            ],
          ),
          if (!isExpired && !isPaid)
            SlideCountdownSeparated(
              duration: duration,
              separator: ":",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
        ],
      ),
    );
  } catch (e) {
    onExpiredStatusChanged(true);
    return Center(child: Text("Format tanggal tidak valid"));
  }
}

Widget _buildPaymentBox(
  BuildContext context,
  String paymentCode,
  String logoChannel,
  String paymentAccess,
) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.blackColor.withOpacity(0.2))),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              paymentCode.isNotEmpty
                  ? paymentCode[0].toUpperCase() +
                      paymentCode.substring(1).toLowerCase()
                  : "",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            // ImageCard(
            //   image: logoChannel,
            //   radius: 0,
            //   width: 45,
            //   height: 45,
            //   imageError: imageDefault,
            // ),
          ],
        ),
        Divider(color: AppColors.blackColor, thickness: .3, height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Nomor Virtual Account',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text(paymentAccess,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
            InkWell(
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: paymentAccess));
                ShowSnackbar.snackbar(context, "Berhasil menyalin nomor VA", '',
                    AppColors.secondaryColor);
              },
              child: const Row(
                children: [
                  Text('Salin',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryColor)),
                  SizedBox(width: 6),
                  Icon(Icons.copy, color: AppColors.secondaryColor),
                ],
              ),
            )
          ],
        ),
      ],
    ),
  );
}

Widget _buildDetailPayment(
  BuildContext context,
  String nameProduct,
  String totalPayment,
) {
  // Menghapus "Terima kasih! telah melakukan transaksi" jika ada dalam nameProduct
  String cleanedNameProduct = nameProduct
      .replaceAll("Terima kasih ! telah melakukan transaksi", "")
      .trim();

  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.blackColor.withOpacity(0.2)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Rincian Pembayaran",
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(
          thickness: .3,
          color: AppColors.blackColor,
        ),
        if (cleanedNameProduct.isNotEmpty) // Menampilkan hanya jika ada isi
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama Produk",
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  cleanedNameProduct,
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Harga Produk",
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              totalPayment,
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
