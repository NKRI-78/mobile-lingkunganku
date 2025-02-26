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
        "https://drive.google.com/file/d/1R_KRK6AWNbMLGNqYRcq5F7p2GFZTBdI9/view";

    final message = Uri.encodeComponent(
        "Halo! Saya ingin mengajak Anda untuk bergabung.\n\n"
        "Kode Referral Warga: $referralCodeWarga\n\n"
        "Download aplikasinya di: $apkDownloadLink\n\n"
        "Yuk, gabung sekarang!");

    final Uri waUrl1 = Uri.parse("https://wa.me/?text=$message");
    final Uri waUrl2 = Uri.parse("whatsapp://send?text=$message");

    try {
      // Coba dengan metode pertama
      if (!await canLaunchUrl(waUrl1)) {
        await launchUrl(waUrl1, mode: LaunchMode.externalApplication);
      }
      // Coba dengan metode kedua (fallback untuk Android 12 ke bawah)
      else if (!await canLaunchUrl(waUrl2)) {
        await launchUrl(waUrl2, mode: LaunchMode.externalApplication);
      }
      // Jika masih gagal, pakai launch() sebagai alternatif
      else {
        await launch(waUrl2.toString());
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tidak dapat membuka WhatsApp"),
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
                      _shareReferralCode(context,
                          state.profile?.chief?.referral ?? "Tidak Tersedia");
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
