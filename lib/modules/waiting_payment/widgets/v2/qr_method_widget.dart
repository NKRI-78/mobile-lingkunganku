import 'package:flutter/material.dart';
import '../../../../widgets/button/custom_button.dart';

import '../../../../misc/colors.dart';
import '../../../../misc/helper.dart';
import '../../../../misc/theme.dart';
import '../../../../repositories/payment_repository/models/payment_model.dart';
import '../../../../widgets/image/image_card.dart';

GlobalKey QrDownload = GlobalKey();

class QrMethodWidgetV2 extends StatelessWidget {
  const QrMethodWidgetV2({super.key, required this.payment});

  final PaymentModel payment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.blackColor.withOpacity(0.2))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  payment.name ?? "-",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ImageCard(
                  image: payment.logoUrl ?? "-",
                  radius: 20,
                  width: 45,
                  height: 45,
                  imageError: imageDefault,
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors.greyColor.withOpacity(0.5),
            thickness: 2,
            height: 5,
          ),
          RepaintBoundary(
            key: QrDownload,
            child: ImageCard(
              image: payment.data?["actions"][0]["url"] ?? "-",
              radius: 10,
              width: double.infinity,
              height: 300,
              imageError: imageDefault,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Expanded(
              //   child: Container(
              //     width: double.infinity,
              //     margin: const EdgeInsets.symmetric(vertical: 10),
              //     child: CustomBotton(
              //       radius: 5,
              //       colorBtn: AppColors.primaryBlue,
              //       onPressed: () {
              //         DownloadHelper.downloadWidget(QrDownload, "${DateFormat('yyyyddMM').format(DateTime.now())}.png", context);
              //       },
              //       isOutline: false,
              //       textButton: "Download QR"
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   width: 10,
              // ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomButton(
                    text: "Bayar Langsung",
                    onPressed: () {
                      Helper.openLink(
                          url: payment.data?["actions"][1]["url"],
                          context: context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
