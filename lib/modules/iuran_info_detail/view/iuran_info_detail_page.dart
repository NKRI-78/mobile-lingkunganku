import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../cubit/iuran_info_detail_cubit.dart';
import '../widget/list_detail_iuran_section.dart';
import '../../../widgets/pages/empty_page.dart';
import '../../../widgets/pages/loading_page.dart';
import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';

class IuranInfoDetailPage extends StatelessWidget {
  final String userId;
  const IuranInfoDetailPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IuranInfoDetailCubit()..fetchContribute(userId),
      child: IuranInfoDetailView(userId: userId),
    );
  }
}

class IuranInfoDetailView extends StatefulWidget {
  final String userId;
  const IuranInfoDetailView({super.key, required this.userId});

  @override
  State<IuranInfoDetailView> createState() => _IuranInfoDetailViewState();
}

class _IuranInfoDetailViewState extends State<IuranInfoDetailView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IuranInfoDetailCubit, IuranInfoDetailState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            surfaceTintColor: Colors.transparent,
            elevation: 2,
            shadowColor: Colors.black.withOpacity(0.3),
            title: Text(
              'Detail Informasi Iuran',
              style: AppTextStyles.textStyle1.copyWith(fontSize: 20),
            ),
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
          body: SafeArea(
            top: false,
            bottom: true,
            child: SmartRefresher(
              controller: IuranInfoDetailCubit.iuranRefreshCtrl,
              enablePullDown: true,
              enablePullUp: false,
              onRefresh: () async {
                await context
                    .read<IuranInfoDetailCubit>()
                    .onRefresh(widget.userId);
              },
              header: ClassicHeader(
                textStyle: const TextStyle(color: AppColors.secondaryColor),
                iconPos: IconPosition.left,
                spacing: 5.0,
                refreshingText: "Memuat informasi iuran...",
                idleText: "Tarik untuk menyegarkan",
                releaseText: "Lepaskan untuk menyegarkan",
                completeText: "Berhasil diperbarui",
                failedText: "Gagal memperbarui",
                refreshingIcon: const Icon(Icons.autorenew,
                    color: AppColors.secondaryColor),
                failedIcon: const Icon(Icons.error, color: Colors.red),
                completeIcon:
                    const Icon(Icons.done, color: AppColors.textColor1),
                idleIcon: const Icon(Icons.arrow_downward,
                    color: AppColors.secondaryColor),
                releaseIcon:
                    const Icon(Icons.refresh, color: AppColors.secondaryColor),
              ),
              child: CustomScrollView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  BlocBuilder<IuranInfoDetailCubit, IuranInfoDetailState>(
                    builder: (context, state) {
                      return SliverPadding(
                        padding: const EdgeInsets.all(20),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              state.isLoading
                                  ? const LoadingPage()
                                  : state.contribute == null ||
                                          state.contribute!.contributions!
                                              .isEmpty
                                      ? const EmptyPage(
                                          msg: "Tidak ada data iuran.")
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: state
                                              .contribute!.contributions!
                                              .map((e) => Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 20),
                                                    child:
                                                        ListDetailIuranSection(
                                                      contribute: e,
                                                    ),
                                                  ))
                                              .toList(),
                                        ),
                            ],
                          ),
                        ),
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
