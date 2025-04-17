import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../profile/cubit/profile_cubit.dart';

class ReferralCodeChief extends StatelessWidget {
  const ReferralCodeChief({super.key});

  void _shareReferralCode(
      BuildContext context, String referralCodeWarga) async {
    const apkDownloadLink =
        "https://play.google.com/store/apps/details?id=com.langitdigital78.mobile_lingkunganku&pcampaignid=web_share";

    final message = "Halo! Saya ingin mengajak Anda untuk bergabung.\n\n"
        "Kode Referral Warga: $referralCodeWarga\n\n"
        "Download aplikasinya di: $apkDownloadLink\n\n"
        "Yuk, gabung sekarang!";

    final encodedMessage = Uri.encodeComponent(message);
    final Uri waUrl = Uri.parse("whatsapp://send?text=$encodedMessage");
    final Uri waWebUrl = Uri.parse("https://wa.me/?text=$encodedMessage");

    try {
      if (await canLaunchUrl(waUrl)) {
        await launchUrl(waUrl, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(waWebUrl)) {
        await launchUrl(waWebUrl, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal membuka WhatsApp: ${e.toString()}"),
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
                        "Referral Code Warga",
                        style: AppTextStyles.textProfileNormal,
                      ),
                      Text(
                        state.profile?.chief?.referral ?? "Tidak Tersedia",
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
                      _shareReferralCode(
                        context,
                        state.profile?.chief?.referral ?? "Tidak Tersedia",
                      );
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
