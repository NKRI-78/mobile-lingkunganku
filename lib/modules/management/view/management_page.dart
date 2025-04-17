import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../misc/text_style.dart';
import '../cubit/management_cubit.dart';
import '../widget/member_tile_section.dart';

class ManagementPage extends StatelessWidget {
  const ManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ManagementCubit>()..fetchManagementMembers(),
      child: const ManagementView(),
    );
  }
}

class ManagementView extends StatefulWidget {
  const ManagementView({super.key});

  @override
  ManagementViewState createState() => ManagementViewState();
}

class ManagementViewState extends State<ManagementView> {
  final ValueNotifier<bool> isExpanded = ValueNotifier(false);
  bool hasInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ManagementCubit>().fetchManagementMembers();
    });
  }

  @override
  void dispose() {
    isExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManagementCubit, ManagementState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (!hasInitialized && state.memberData?.data?.members != null) {
          isExpanded.value = state.memberData!.data!.members.isNotEmpty;
          hasInitialized = true;
        }
      },
      child: BlocBuilder<ManagementCubit, ManagementState>(
        builder: (context, state) {
          print("State saat ini: ${state.memberData?.data?.members}");
          return Scaffold(
            backgroundColor: Colors.green.shade100,
            body: RefreshIndicator(
              color: AppColors.secondaryColor,
              onRefresh: () async {
                context.read<ManagementCubit>().fetchManagementMembers();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 50, bottom: 20, right: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nama Lingkungan", style: AppTextStyles.textStyle2),
                      const SizedBox(height: 4),
                      Text(state.memberData?.data?.name ?? "",
                          style: AppTextStyles.textStyle1),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.textColor1,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                GoRouter.of(context).pop();
                              },
                              icon: const Icon(Icons.home, color: Colors.white),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "${state.memberData?.data?.totalMember.toString() ?? 'N/A'} Warga",
                              style: AppTextStyles.textProfileBold,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              onPressed: () {
                                _shareDownloadLink(context);
                              },
                              icon: Icon(
                                Icons.share,
                                color: AppColors.whiteColor,
                                size: 22,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Warga Terdaftar",
                                  style: AppTextStyles.textDialog),
                              trailing: ValueListenableBuilder<bool>(
                                valueListenable: isExpanded,
                                builder: (context, expanded, child) {
                                  return Icon(expanded
                                      ? Icons.expand_less
                                      : Icons.expand_more);
                                },
                              ),
                              onTap: () {
                                isExpanded.value = !isExpanded.value;
                              },
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable: isExpanded,
                              builder: (context, expanded, child) {
                                final members = List.from(
                                    state.memberData?.data?.members ?? []);
                                members.sort((a, b) => a.id.compareTo(b.id));

                                return AnimatedSize(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                  child: expanded
                                      ? Column(
                                          children: members.isNotEmpty
                                              ? members.map((member) {
                                                  return MemberTile(
                                                    userId:
                                                        member.id.toString(),
                                                    name: member.profile
                                                            ?.fullname ??
                                                        "Nama tidak tersedia",
                                                    role: member
                                                            .translateRoleApp
                                                            .isNotEmpty
                                                        ? member
                                                            .translateRoleApp
                                                        : "Role tidak tersedia",
                                                    avatarUrl: member
                                                        .profile?.avatarLink,
                                                  );
                                                }).toList()
                                              : [
                                                  const Padding(
                                                    padding: EdgeInsets.all(16),
                                                    child: Text(
                                                        "Belum ada warga terdaftar."),
                                                  ),
                                                ],
                                        )
                                      : const SizedBox.shrink(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void _shareDownloadLink(BuildContext context) async {
  const apkDownloadLink =
      "https://play.google.com/store/apps/details?id=com.langitdigital78.mobile_lingkunganku&pcampaignid=web_share";

  final message =
      "Halo! Saya ingin mengajak Anda untuk bergabung di lingkungan ini.\n\n"
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
