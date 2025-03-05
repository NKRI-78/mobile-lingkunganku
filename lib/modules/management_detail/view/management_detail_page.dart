import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../misc/injections.dart';
import '../../../misc/text_style.dart';
import '../cubit/management_detail_cubit.dart';
import '../widget/join_date_section.dart';
import '../widget/management_acces_section.dart';
import '../widget/payment_section.dart';
import '../widget/profile_section.dart';
import '../widget/remove_user_section.dart';
import '../widget/user_info_section.dart';

import '../../../misc/colors.dart';
import '../../../repositories/management_repository/management_repository.dart';

class ManagementDetailPage extends StatelessWidget {
  final String userId;

  const ManagementDetailPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManagementDetailCubit(getIt<ManagementRepository>())
        ..fetchManagementDetailMembers(userId: userId),
      child: ManagementDetailView(),
    );
  }
}

class ManagementDetailView extends StatelessWidget {
  const ManagementDetailView({super.key});

  @override
  Widget build(BuildContext context) {
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
          if (state.isLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.secondaryColor,
            ));
          }

          if (state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          }

          final memberManagement = state.memberDetail?.data;

          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSection(member: memberManagement),
                JoinDateSection(
                  member: memberManagement,
                ),
                UserInfoSection(
                  member: memberManagement,
                ),
                PaymentSection(),
                ManagementAccesSection(
                  member: memberManagement,
                ),
                BlocProvider.value(
                  value: context.read<ManagementDetailCubit>(),
                  child: RemoveUserSection(
                    member: memberManagement,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
