import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/modules/management/cubit/management_cubit.dart';
import 'package:mobile_lingkunganku/repositories/management_repository/management_repository.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../widget/member_tile_section.dart';

class ManagementPage extends StatelessWidget {
  const ManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManagementCubit(getIt<ManagementRepository>())
        ..fetchManagementMembers(), // Fetch data awal
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
      // Pastikan data di-fetch ulang setiap kali halaman ini ditampilkan kembali
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
      listener: (context, state) {
        if (!hasInitialized && state.memberData?.data?.members != null) {
          isExpanded.value = state.memberData!.data!.members.isNotEmpty;
          hasInitialized = true;
        }
      },
      child: BlocBuilder<ManagementCubit, ManagementState>(
        builder: (context, state) {
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
                                size: 16,
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
      "https://drive.google.com/file/d/1R_KRK6AWNbMLGNqYRcq5F7p2GFZTBdI9/view";

  final message = Uri.encodeComponent(
      "Halo! Saya ingin mengajak Anda untuk bergabung di lingkungan ini.\n\n"
      "Download aplikasinya di: $apkDownloadLink\n\n"
      "Yuk, gabung sekarang!");

  final Uri url = Uri.parse("https://wa.me/?text=$message");

  if (!await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tidak dapat membuka WhatsApp")));
  }
}
