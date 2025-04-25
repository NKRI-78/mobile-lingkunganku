import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../repositories/ppob_repository/models/pulsa_data_model.dart';

class CustomListPulsaDataSection extends StatefulWidget {
  final List<PulsaDataModel> pulsaData;
  final Function(PulsaDataModel) onSelected;

  const CustomListPulsaDataSection({
    super.key,
    required this.pulsaData,
    required this.onSelected,
  });

  @override
  State<CustomListPulsaDataSection> createState() =>
      _CustomListPulsaDataSectionState();
}

class _CustomListPulsaDataSectionState
    extends State<CustomListPulsaDataSection> {
  int? selectedIndex; // Menyimpan indeks kartu yang dipilih

  @override
  Widget build(BuildContext context) {
    return widget.pulsaData.isEmpty
        ? Center(
            child: Text(
              "Tidak ada paket pulsa tersedia",
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          )
        : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.2,
            ),
            itemCount: widget.pulsaData.length,
            itemBuilder: (context, index) {
              final pulsa = widget.pulsaData[index];
              final isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });

                  // Kirim data pulsa yang dipilih ke PpobView
                  widget.onSelected(pulsa);
                },
                child: Card(
                  color: isSelected ? AppColors.whiteColor : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color:
                          isSelected ? AppColors.secondaryColor : Colors.white,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  elevation: isSelected ? 5 : 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          pulsa.name ?? "Paket Tidak Diketahui",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.textWelcome
                              .copyWith(color: AppColors.blackColor),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          formatCurrency(pulsa.price ?? 0),
                          style: AppTextStyles.textStyle2,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  // Fungsi untuk memformat harga ke Rupiah
  String formatCurrency(int price) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(price);
  }
}
