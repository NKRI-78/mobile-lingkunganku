import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../misc/text_style.dart';
import '../../../repositories/management_repository/management_repository.dart';
import '../cubit/transfer_management_cubit.dart';
import '../widget/member_list_section.dart';

class TransferManagementPage extends StatelessWidget {
  const TransferManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TransferManagementCubit(getIt<ManagementRepository>())
            ..fetchManagementMembers(),
      child: TransferManagementView(),
    );
  }
}

class TransferManagementView extends StatefulWidget {
  const TransferManagementView({super.key});

  @override
  State<TransferManagementView> createState() => _TransferManagementViewState();
}

class _TransferManagementViewState extends State<TransferManagementView> {
  final ValueNotifier<bool> isExpanded = ValueNotifier(false);
  bool hasInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Pastikan data di-fetch ulang setiap kali halaman ini ditampilkan kembali
      context.read<TransferManagementCubit>().fetchManagementMembers();
    });
  }

  @override
  void dispose() {
    isExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransferManagementCubit, TransferManagementState>(
      listener: (context, state) {
        if (!hasInitialized && state.memberData?.data?.members != null) {
          isExpanded.value = state.memberData!.data!.members.isNotEmpty;
          hasInitialized = true;
        }
      },
      child: BlocBuilder<TransferManagementCubit, TransferManagementState>(
        builder: (context, state) {
          final role = state.memberData?.data?.roleApp;
          print("role : ${role}");
          return Scaffold(
            backgroundColor: Colors.green.shade100,
            body: RefreshIndicator(
              color: AppColors.secondaryColor,
              onRefresh: () async {
                context
                    .read<TransferManagementCubit>()
                    .fetchManagementMembers();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 50, bottom: 20, right: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.memberData?.data?.name ?? "",
                          style: AppTextStyles.textStyle1),
                      SizedBox(height: 10),
                      Text("Pilih Ketua Lingkungan Baru",
                          style: AppTextStyles.textStyle2),
                      SizedBox(height: 10),
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
                              icon: Icon(
                                Icons.home_outlined,
                                color: AppColors.whiteColor,
                              ),
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
                        ],
                      ),
                      SizedBox(height: 20),
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
                                              ? members.map(
                                                  (member) {
                                                    return MemberListSection(
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
                                                  },
                                                ).toList()
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
