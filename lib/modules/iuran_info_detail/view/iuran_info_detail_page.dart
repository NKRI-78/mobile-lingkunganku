import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: const IuranInfoDetailView(),
    );
  }
}

class IuranInfoDetailView extends StatefulWidget {
  const IuranInfoDetailView({super.key});

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
              style: AppTextStyles.textStyle1.copyWith(fontSize: 21),
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
          body: CustomScrollView(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            slivers: [
              BlocBuilder<IuranInfoDetailCubit, IuranInfoDetailState>(
                builder: (context, state) {
                  return SliverPadding(
                    padding: const EdgeInsets.all(20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        state.isLoading
                            ? const LoadingPage()
                            : state.contribute == null ||
                                    state.contribute!.contributions!.isEmpty
                                ? const EmptyPage(msg: "Tidak ada data iuran.")
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: state.contribute!.contributions!
                                        .map((e) => Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20),
                                              child: ListDetailIuranSection(
                                                contribute: e,
                                              ),
                                            ))
                                        .toList(),
                                  ),
                      ]),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
