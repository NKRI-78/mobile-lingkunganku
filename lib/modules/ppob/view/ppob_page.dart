import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/modules/ppob/cubit/ppob_cubit.dart';
import 'package:mobile_lingkunganku/widgets/contact/contact_list_ppob.dart';
import 'package:mobile_lingkunganku/widgets/header/header_text.dart';

import '../../../misc/text_style.dart';

part '../widget/custom_card_section.dart';
part '../widget/custom_field_section.dart';

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
  final TextEditingController _controller = TextEditingController();
  int selectedIndex = -1;
  String? selectedType; // Tambahkan state untuk menyimpan tipe

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onCardSelected(int index) {
    setState(() {
      selectedIndex = index;
      selectedType = index == 0 ? "PULSA" : (index == 1 ? "DATA" : null);
    });

    if (_controller.text.isNotEmpty && selectedType != null) {
      // Fetch ulang dengan type yang baru
      context.read<PpobCubit>().fetchPulsaData(
            prefix: _controller.text.substring(0, 4),
            type: selectedType!,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
        child: InkWell(
          onTap: selectedIndex == -1
              ? null
              : () {
                  // Aksi lanjutkan hanya aktif jika card sudah dipilih
                },
          child: Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              color:
                  selectedIndex == -1 ? Colors.grey : AppColors.secondaryColor,
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
        ),
      ),
      body: CustomScrollView(
        slivers: [
          HeaderText(text: "Pulsa & Tagihan"),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                CustomCardSection(
                  selectedIndex: selectedIndex,
                  onCardSelected: _onCardSelected, // Tambahkan callback
                ),
                const SizedBox(height: 20),
                if (selectedIndex == 0 || selectedIndex == 1)
                  CustomFieldSection(
                      controller: _controller, type: selectedType),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
