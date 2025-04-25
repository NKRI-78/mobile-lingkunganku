import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../cubit/profile_cubit.dart';

class ReferralCodeFamily extends StatelessWidget {
  const ReferralCodeFamily({super.key});

  void _shareReferralCode(
      BuildContext context, String referralCodeFamily) async {
    const apkDownloadLink =
        "https://play.google.com/store/apps/details?id=com.langitdigital78.mobile_lingkunganku&pcampaignid=web_share";

    final message = "Halo! Saya ingin mengajak Anda untuk bergabung.\n\n"
        "Kode Referral Keluarga: $referralCodeFamily\n\n"
        "Download aplikasinya di: $apkDownloadLink\n\n"
        "Yuk, gabung sekarang!";

    final encodeMessage = Uri.encodeComponent(message);

    final Uri waUrl = Platform.isIOS
        ? Uri.parse("whatsapp://send?text=$encodeMessage")
        : Uri.parse("https://wa.me/?text=$encodeMessage");

    final Uri waWebUrl = Uri.parse("https://wa.me/?text=$encodeMessage");

    try {
      // Periksa jika WhatsApp dapat diluncurkan
      if (!await canLaunchUrl(waUrl)) {
        await launchUrl(waUrl, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(waWebUrl)) {
        // Jika tidak ada WhatsApp, fallback ke web URL
        await launchUrl(waWebUrl, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Tidak dapat membuka WhatsApp."),
            backgroundColor: AppColors.redColor,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: AppColors.redColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.whiteColor,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Referral Code Family",
                        style: AppTextStyles.textProfileNormal,
                      ),
                      Text(
                        state.profile?.family?.referral ?? "Tidak Tersedia",
                        style: AppTextStyles.textProfileBold,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.share_outlined,
                      color: AppColors.whiteColor,
                    ),
                    onPressed: () {
                      _shareReferralCode(context,
                          state.profile?.family?.referral ?? "Tidak Tersedia");
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
