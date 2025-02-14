import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../misc/text_style.dart';
import '../../home/bloc/home_bloc.dart';
import '../cubit/profile_cubit.dart';
import '../widget/family_member_section.dart';
import '../widget/referral_code_chief.dart';
import '../widget/referral_code_family.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/background/custom_background.dart';
import '../../../widgets/header/custom_header_container.dart';
import '../widget/profile_info_section.dart';
import '../widget/transfer_management_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ProfileCubit>()..getProfile(),
      child: ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final String role = getIt<HomeBloc>().state.profile?.roleApp ?? '';

  void _shareReferralCode(BuildContext context, String referralCodeWarga,
      String referralCodeFamily) async {
    const apkDownloadLink =
        "https://drive.google.com/file/d/1R_KRK6AWNbMLGNqYRcq5F7p2GFZTBdI9/view";

    final message = Uri.encodeComponent(
        "Halo! Saya ingin mengajak Anda untuk bergabung.\n\n"
        " Kode Referral Warga: $referralCodeWarga\n"
        " Kode Referral Keluarga: $referralCodeFamily\n\n"
        " Download aplikasinya di: $apkDownloadLink\n\n"
        "Yuk, gabung sekarang!");

    final Uri url = Uri.parse("https://wa.me/?text=$message");

    if (!await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Tidak dapat membuka WhatsApp")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final saldo = state.profile?.balance ?? 0;
        final referralCodeWarga = state.profile?.chief?.referral ?? "Tidak ada";
        final referralCodeFamily =
            state.profile?.family?.referral ?? "Tidak ada";

        return Scaffold(
          body: Stack(
            children: [
              const CustomBackground(),
              Column(
                children: [
                  CustomHeaderContainer(
                    avatarLink: state.profile?.profile?.avatarLink ?? '',
                    isLoggedIn: true,
                    displayText: '',
                    showText: false,
                    title: 'Profile',
                    onBackPressed: () => Navigator.pop(context),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Saldo : ",
                                      style: AppTextStyles.textWelcome.copyWith(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Rp${saldo.toStringAsFixed(0)}",
                                      style: AppTextStyles.textWelcome.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  print("Topup Wallet ditekan");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  minimumSize: const Size(120, 40),
                                  elevation: 0,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.wallet_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "Topup Wallet",
                                      style: AppTextStyles.textProfileNormal
                                          .copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        spacing: 20,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProfileInfoSection(),
                          if (role != "MEMBER") TransferManagementSection(),
                          if (state.families != null &&
                              state.families!.isNotEmpty)
                            FamilyMemberSection(
                              families: state.families!,
                            ),
                          if (role != "MEMBER") ReferralCodeChief(),
                          ReferralCodeFamily(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                text: 'Bagikan ke WhatsApp',
                                onPressed: () {
                                  _shareReferralCode(context, referralCodeWarga,
                                      referralCodeFamily);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
