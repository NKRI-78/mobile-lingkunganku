import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../cubit/management_detail_cubit.dart';
import '../widget/join_date_section.dart';
import '../widget/management_acces_section.dart';
import '../widget/payment_section.dart';
import '../widget/profile_section.dart';
import '../widget/remove_user_section.dart';
import '../widget/user_info_section.dart';

class ManagementDetailPage extends StatelessWidget {
  final String userId;

  const ManagementDetailPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ManagementDetailCubit()..fetchManagementDetailMembers(userId: userId),
      child: const ManagementDetailView(),
    );
  }
}

class ManagementDetailView extends StatelessWidget {
  const ManagementDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagementDetailCubit, ManagementDetailState>(
      builder: (context, state) {
        final String role = (state.profile?.roleApp ?? 'MEMBER').toUpperCase();
        print("Role Pengguna : ${role}");

        return Scaffold(
          backgroundColor: Colors.green.shade50,
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            title: Text(
              'Profile Member',
              style: AppTextStyles.textStyle1.copyWith(fontSize: 20),
            ),
            centerTitle: true,
            toolbarHeight: 100,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20, top: 30, bottom: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.blackColor.withOpacity(0.8),
                    size: 20,
                  ),
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                ),
              ),
            ),
          ),
          body: BlocBuilder<ManagementDetailCubit, ManagementDetailState>(
            builder: (context, state) {
              final memberManagement = state.memberDetail?.data;

              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    state.isLoading
                        ? const ProfileSectionShimmer()
                        : ProfileSection(member: memberManagement),
                    state.isLoading
                        ? const JoinDateSectionShimmer()
                        : JoinDateSection(member: memberManagement),
                    state.isLoading
                        ? const UserInfoSectionShimmer()
                        : UserInfoSection(member: memberManagement),
                    if (role == "CHIEF" || role == "TREASURER")
                      state.isLoading
                          ? const PaymentSectionShimmer()
                          : PaymentSection(),
                    if (role == "CHIEF")
                      state.isLoading
                          ? const ManagementAccessSectionShimmer()
                          : ManagementAccesSection(member: memberManagement),
                    if (role == "CHIEF")
                      state.isLoading
                          ? const RemoveUserSectionShimmer()
                          : BlocProvider.value(
                              value: context.read<ManagementDetailCubit>(),
                              child:
                                  RemoveUserSection(member: memberManagement),
                            ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class ProfileSectionShimmer extends StatelessWidget {
  const ProfileSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class JoinDateSectionShimmer extends StatelessWidget {
  const JoinDateSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 20,
        width: 150,
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

class UserInfoSectionShimmer extends StatelessWidget {
  const UserInfoSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(
          3,
          (index) => Container(
            height: 20,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentSectionShimmer extends StatelessWidget {
  const PaymentSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 60,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class ManagementAccessSectionShimmer extends StatelessWidget {
  const ManagementAccessSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 40,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class RemoveUserSectionShimmer extends StatelessWidget {
  const RemoveUserSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
