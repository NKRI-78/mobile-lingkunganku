import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/modules/management/cubit/management_cubit.dart';
import 'package:mobile_lingkunganku/repositories/management_repository/management_repository.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../repositories/management_repository/models/management_detail_member_model.dart';
import '../widget/member_tile_section.dart';

class ManagementPage extends StatelessWidget {
  const ManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManagementCubit(getIt<ManagementRepository>())
        ..fetchManagementMembers(),
      child: const ManagementView(),
    );
  }
}

class ManagementView extends StatefulWidget {
  final MemberData? member;

  const ManagementView({super.key, this.member});

  @override
  ManagementViewState createState() => ManagementViewState();
}

class ManagementViewState extends State<ManagementView> {
  final ValueNotifier<bool> isExpanded = ValueNotifier(false);
  bool hasInitialized = false;

  @override
  void dispose() {
    isExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagementCubit, ManagementState>(
      builder: (context, state) {
        if (!hasInitialized && state.memberData?.data?.members != null) {
          isExpanded.value = state.memberData!.data!.members.isNotEmpty;
          hasInitialized = true;
        }

        return Scaffold(
          backgroundColor: Colors.green.shade100,
          body: SingleChildScrollView(
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
                      const SizedBox(width: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "${state.memberData?.data?.totalMember.toString() ?? 'N/A'} Member",
                          style: AppTextStyles.textProfileBold,
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
                          title: Text("Anggota Terdaftar",
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

                            return AnimatedCrossFade(
                              duration: const Duration(milliseconds: 400),
                              crossFadeState: expanded
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                              firstChild: members.isNotEmpty
                                  ? Column(
                                      children: members.map((member) {
                                        return MemberTile(
                                          userId: member.id.toString(),
                                          name: member.profile?.fullname ??
                                              "Nama tidak tersedia",
                                          role:
                                              member.translateRoleApp.isNotEmpty
                                                  ? member.translateRoleApp
                                                  : "Role tidak tersedia",
                                          avatarUrl: member.profile?.avatarLink,
                                        );
                                      }).toList(),
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.all(16),
                                      child:
                                          Text("Belum ada anggota terdaftar."),
                                    ),
                              secondChild: const SizedBox.shrink(),
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
        );
      },
    );
  }
}
