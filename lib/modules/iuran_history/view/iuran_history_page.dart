import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../misc/injections.dart';
import '../cubit/iuran_history_cubit.dart';
import '../widget/list_history_iuran_section.dart';
import '../../../widgets/pages/empty_page.dart';
import '../../../widgets/pages/loading_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';

class IuranHistoryPage extends StatelessWidget {
  const IuranHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<IuranHistoryCubit>()..getPaidInvoices(),
      child: IuranHistoryView(),
    );
  }
}

class IuranHistoryView extends StatefulWidget {
  const IuranHistoryView({super.key});

  @override
  _IuranHistoryViewState createState() => _IuranHistoryViewState();
}

class _IuranHistoryViewState extends State<IuranHistoryView> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await context.read<IuranHistoryCubit>().getPaidInvoices();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IuranHistoryCubit, IuranHistoryState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            surfaceTintColor: Colors.transparent,
            elevation: 2,
            shadowColor: Colors.black.withOpacity(0.3),
            title: Text('Riwayat Iuran', style: AppTextStyles.textStyle1),
            centerTitle: true,
            toolbarHeight: 100,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: AppColors.buttonColor2, size: 24),
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
              refreshingText: "Memuat Riwayat Iuran...",
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
            child: state.isLoading
                ? const LoadingPage()
                : state.iuran == null || state.iuran!.isEmpty
                    ? const EmptyPage(msg: "Tidak ada Riwayat Iuran..")
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.iuran!.length,
                        itemBuilder: (context, index) {
                          final iuran = state.iuran![index];
                          return ListHistoryIuranSection(iuran: iuran);
                        },
                      ),
          ),
        );
      },
    );
  }
}
