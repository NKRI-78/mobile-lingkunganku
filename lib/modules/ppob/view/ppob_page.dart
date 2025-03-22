import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/misc/injections.dart';
import 'package:mobile_lingkunganku/modules/app/bloc/app_bloc.dart';
import 'package:mobile_lingkunganku/modules/ppob/view/ppob_waiting_payment_page.dart';
import '../../../misc/colors.dart';
import '../../../misc/price_currency.dart';
import '../../../misc/snackbar.dart';
import '../../../widgets/button/custom_button.dart';
import '../cubit/ppob_cubit.dart';
import '../../../widgets/contact/contact_list_ppob.dart';
import '../../../widgets/header/header_text.dart';

import '../../../misc/text_style.dart';
import '../../../repositories/ppob_repository/models/pulsa_data_model.dart';
import '../widget/custom_list_pulsa_data_section.dart';

part '../widget/custom_card_section.dart';
part '../widget/custom_field_section.dart';
part '../widget/custom_payment_section.dart';

class PpobPage extends StatelessWidget {
  const PpobPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PpobCubit(),
      child: const PpobView(),
    );
  }
}

class PpobView extends StatefulWidget {
  const PpobView({super.key});

  @override
  State<PpobView> createState() => _PpobViewState();
}

class _PpobViewState extends State<PpobView> {
  int selectedIndex = -1;
  String? selectedType;
  final ValueNotifier<PulsaDataModel?> selectedPulsaDataNotifier =
      ValueNotifier(null);
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    selectedPulsaDataNotifier.dispose();
    super.dispose();
  }

  void _onCardSelected(int index) {
    setState(() {
      selectedIndex = index;
      selectedType = index == 0 ? "PULSA" : (index == 1 ? "DATA" : null);
      selectedPulsaDataNotifier.value =
          null; // Reset pilihan pulsa saat berganti kategori
    });

    final cubit = context.read<PpobCubit>();

    if (selectedType == null) {
      cubit.clearPulsaData();
    } else if (_controller.text.length >= 5) {
      cubit.fetchPulsaData(
        prefix: _controller.text.substring(0, 5),
        type: selectedType!,
      );
    }
  }

  void _onPulsaDataSelected(PulsaDataModel pulsa) {
    selectedPulsaDataNotifier.value = pulsa;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
        child: ValueListenableBuilder<PulsaDataModel?>(
          valueListenable: selectedPulsaDataNotifier,
          builder: (context, selectedPulsaData, child) {
            return InkWell(
              onTap: (selectedIndex == -1 || selectedPulsaData == null)
                  ? null
                  : () {
                      _customPaymentSection(context, [selectedPulsaData],
                          _controller.text, selectedType ?? "PULSA");
                      final cubit = context.read<PpobCubit>();
                      cubit.copyState(
                          newState: cubit.state
                              .copyWith(selectedPulsaData: selectedPulsaData));
                    },
              child: Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                  color: (selectedIndex == -1 || selectedPulsaData == null)
                      ? Colors.grey
                      : AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    "Lanjutkan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      body: CustomScrollView(
        slivers: [
          HeaderText(text: "Pulsa & Tagihan"),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final widgets = [
                    CustomCardSection(
                      selectedIndex: selectedIndex,
                      onCardSelected: _onCardSelected,
                    ),
                    const SizedBox(height: 20),
                    if (selectedIndex == 0 || selectedIndex == 1)
                      CustomFieldSection(
                          controller: _controller, type: selectedType),
                    const SizedBox(height: 10),
                    BlocBuilder<PpobCubit, PpobState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(
                            heightFactor: 5,
                            child: CircularProgressIndicator(
                                color: AppColors.secondaryColor),
                          );
                        } else if (state.isSuccess == true &&
                            state.pulsaData.isNotEmpty) {
                          return CustomListPulsaDataSection(
                            pulsaData: state.pulsaData,
                            onSelected: _onPulsaDataSelected,
                          );
                        } else if (state.isSuccess == false) {
                          return Center(
                            child: Text("Terjadi kesalahan",
                                style: TextStyle(color: Colors.red)),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ];

                  // ✅ Pastikan index aman sebelum mengakses list
                  if (index >= widgets.length) {
                    return const SizedBox.shrink(); // Menghindari RangeError
                  }

                  return widgets[index];
                },
                childCount: (selectedIndex == 0 || selectedIndex == 1)
                    ? 5
                    : 4, // ✅ Sesuaikan childCount
              ),
            ),
          ),
        ],
      ),
    );
  }
}
