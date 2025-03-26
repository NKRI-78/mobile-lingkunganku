import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../widgets/pages/empty_page.dart';
import '../../../widgets/pages/loading_page.dart';
import '../cubit/iuran_info_cubit.dart';
import '../widget/list_iuran_info_section.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';

class IuranInfoPage extends StatelessWidget {
  const IuranInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IuranInfoCubit()..fetchManagementMembers(),
      child: const IuranInfoView(),
    );
  }
}

class IuranInfoView extends StatefulWidget {
  const IuranInfoView({super.key});

  @override
  State<IuranInfoView> createState() => _IuranInfoViewState();
}

class _IuranInfoViewState extends State<IuranInfoView> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await context.read<IuranInfoCubit>().fetchManagementMembers();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IuranInfoCubit, IuranInfoState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            surfaceTintColor: Colors.transparent,
            elevation: 2,
            shadowColor: Colors.black.withOpacity(0.3),
            title: Text('Informasi Iuran', style: AppTextStyles.textStyle1),
            centerTitle: true,
            toolbarHeight: 100,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.buttonColor2,
                size: 24,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ),
          body: SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            enablePullDown: true,
            physics: const BouncingScrollPhysics(),
            header: ClassicHeader(
              textStyle: const TextStyle(color: AppColors.secondaryColor),
              iconPos: IconPosition.left,
              spacing: 5.0,
              refreshingText: "Memuat Informasi Iuran...",
              idleText: "Tarik untuk menyegarkan",
              releaseText: "Lepaskan untuk menyegarkan",
              completeText: "Berhasil diperbarui",
              failedText: "Gagal memperbarui",
              refreshingIcon:
                  const Icon(Icons.autorenew, color: AppColors.secondaryColor),
              failedIcon: const Icon(Icons.error, color: Colors.red),
              completeIcon: const Icon(Icons.done, color: AppColors.textColor1),
              idleIcon: const Icon(Icons.arrow_downward,
                  color: AppColors.secondaryColor),
              releaseIcon:
                  const Icon(Icons.refresh, color: AppColors.secondaryColor),
            ),
            child: BlocBuilder<IuranInfoCubit, IuranInfoState>(
              buildWhen: (previous, current) =>
                  previous.memberData != current.memberData ||
                  previous.isLoading != current.isLoading,
              builder: (context, state) {
                final members = state.memberData?.data?.members ?? [];

                if (state.isLoading) {
                  return const LoadingPage();
                }

                if (members.isEmpty) {
                  return const EmptyPage(
                    msg: "Data Member Belum Tersedia..",
                  );
                }

                return CustomScrollView(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final member = members[index];
                            return ListIuranInfoSection(
                              userId: member.id.toString(),
                              name:
                                  member.profile?.fullname ?? "Tidak ada nama",
                              avatarUrl: member.profile?.avatarLink,
                            );
                          },
                          childCount: members.length,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
