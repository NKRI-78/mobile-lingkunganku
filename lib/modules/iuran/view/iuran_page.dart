import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_lingkunganku/misc/price_currency.dart';
import '../../../misc/colors.dart';
import '../../../misc/date_helper.dart';
import '../../../misc/snackbar.dart';
import '../../../misc/text_style.dart';
import '../../../widgets/pages/empty_page.dart';
import '../cubit/iuran_cubit.dart';
import '../../../repositories/iuran_repository/models/iuran_model.dart';
import '../../../router/builder.dart';
import '../../../widgets/button/custom_button.dart';

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
  Widget build(BuildContext context) {
    return BlocBuilder<IuranCubit, IuranState>(
      builder: (context, state) {
        final List<Data> iuranList = state.iuran?.data ?? [];

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
              IconButton(
                icon: const Icon(
                  Icons.event_note_sharp,
                  color: AppColors.buttonColor2,
                  size: 26,
                ),
                onPressed: () {
                  IuranHistoryRoute().go(context);
                },
              ),
            ],
          ),
          body: RefreshIndicator(
            color: AppColors.secondaryColor,
            onRefresh: () async {
              _selectedInvoices.value = [];
              context.read<IuranCubit>().getInvoice();
              await Future.delayed(const Duration(seconds: 1));
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
                final int totalAmount = selected.fold(
                    0, (sum, item) => sum + (item.totalAmount ?? 0));
                return CustomButton(
                  text: "BAYAR TAGIHAN\n\nTotal Tagihan Rp $totalAmount",
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
  }
}
