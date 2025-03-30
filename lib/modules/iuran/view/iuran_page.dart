import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../app/bloc/app_bloc.dart';

import '../../../misc/colors.dart';
import '../../../misc/date_helper.dart';
import '../../../misc/price_currency.dart';
import '../../../misc/text_style.dart';
import '../../../repositories/iuran_repository/models/iuran_model.dart';
import '../../../router/builder.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/pages/empty_page.dart';
import '../cubit/iuran_cubit.dart';

part '../widget/custom_list_invoice_section.dart';
part '../widget/custom_payment_section.dart';

class IuranPage extends StatelessWidget {
  const IuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IuranCubit()..getInvoice(),
      child: const IuranView(),
    );
  }
}

class IuranView extends StatefulWidget {
  const IuranView({super.key});

  @override
  State<IuranView> createState() => _IuranViewState();
}

class _IuranViewState extends State<IuranView> {
  final ValueNotifier<List<Data>> _selectedInvoices = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final iuranList = context.read<IuranCubit>().state.iuran?.data ?? [];

      if (iuranList.isNotEmpty) {
        // Cari invoice pertama yang belum dibayar
        final firstUnpaidInvoice = iuranList.firstWhere(
          (item) => item.translateStatus == "Belum Bayar",
          orElse: () =>
              iuranList.first, // Jika semua sudah dibayar, pilih pertama
        );

        // Tambahkan invoice pertama ke dalam daftar selected jika belum ada
        if (!_selectedInvoices.value.contains(firstUnpaidInvoice)) {
          _selectedInvoices.value = [firstUnpaidInvoice];
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IuranCubit, IuranState>(
      builder: (context, state) {
        final List<Data> iuranList = state.iuran?.data ?? [];

        // **Perbarui pilihan setelah data dimuat**
        if (iuranList.isNotEmpty && _selectedInvoices.value.isEmpty) {
          final firstUnpaidInvoice = iuranList.firstWhere(
            (item) => item.translateStatus == "Belum Bayar",
            orElse: () => iuranList.first,
          );
          _selectedInvoices.value = [firstUnpaidInvoice];
        }

        return BlocBuilder<AppBloc, AppState>(
          builder: (context, st) {
            return Scaffold(
              backgroundColor: Colors.grey[100],
              appBar: AppBar(
                backgroundColor: AppColors.whiteColor,
                surfaceTintColor: Colors.transparent,
                elevation: 2,
                shadowColor: Colors.black.withOpacity(0.3),
                title: Text('Iuran', style: AppTextStyles.textStyle1),
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
                actions: [
                  st.profile?.headmaster == null
                      ? Container()
                      : IconButton(
                          icon: const Icon(
                            Icons.event_note_sharp,
                            color: AppColors.buttonColor2,
                            size: 26,
                          ),
                          onPressed: () {
                            IuranHistoryRoute().go(context);
                          },
                        )
                ],
              ),
              body: RefreshIndicator(
                color: AppColors.secondaryColor,
                onRefresh: () async {
                  _selectedInvoices.value = []; // Reset pilihan

                  await context.read<IuranCubit>().getInvoice();
                  await Future.delayed(const Duration(seconds: 1));

                  // Ambil data terbaru setelah refresh
                  final iuranList =
                      context.read<IuranCubit>().state.iuran?.data ?? [];

                  if (iuranList.isNotEmpty) {
                    // Cari invoice pertama yang belum dibayar
                    final firstUnpaidInvoice = iuranList.firstWhere(
                      (item) => item.translateStatus == "Belum Bayar",
                      orElse: () => iuranList
                          .first, // Jika semua sudah dibayar, pilih pertama
                    );

                    // Tambahkan invoice pertama ke dalam daftar selected jika belum ada
                    _selectedInvoices.value = [firstUnpaidInvoice];
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomListInvoiceSection(
                    isLoading: state.isLoading,
                    iuran: iuranList,
                    selectedInvoices: _selectedInvoices,
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
                child: ValueListenableBuilder<List<Data>>(
                  valueListenable: _selectedInvoices,
                  builder: (context, selected, child) {
                    return st.profile?.headmaster == null
                        ? SizedBox.shrink()
                        : CustomButton(
                            text: "Bayar Iuran",
                            onPressed: selected.isNotEmpty
                                ? () {
                                    _customPaymentSection(context, selected);
                                  }
                                : null,
                          );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
