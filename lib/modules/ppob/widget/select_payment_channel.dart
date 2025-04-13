import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/ppob_cubit.dart';

import '../../../misc/colors.dart';
import '../../../misc/price_currency.dart';
import '../../../misc/text_style.dart';
import '../../../misc/theme.dart';
import '../../../widgets/image/image_card.dart';

class SelectPaymentChannel extends StatelessWidget {
  const SelectPaymentChannel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PpobCubit, PpobState>(
      builder: (context, state) {
        final filteredChannels = state.channels;

        // Pakai harga pulsa aja
        final double pulsaPrice =
            state.selectedPulsaData?.price?.toDouble() ?? 0;
        final bool isBelowMinimum = pulsaPrice < 50000;

        return WillPopScope(
          onWillPop: () async => false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_outlined,
                          color: AppColors.blackColor),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        "Pilih Metode Pembayaran",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.textProfileBold.copyWith(
                          color: AppColors.blackColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 25),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 20),

                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredChannels.length,
                    itemBuilder: (context, index) {
                      final e = filteredChannels[index];

                      final isGoPay = (e.paymentType?.toUpperCase() ?? "")
                          .contains("GOPAY");
                      final isSelectable = !isBelowMinimum || isGoPay;

                      return Card(
                        color: AppColors.whiteColor,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          title: Text(
                            e.name == "Saldo"
                                ? "Lingkunganku Wallet"
                                : e.name ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: isSelectable
                                  ? AppColors.blackColor
                                  : Colors.grey,
                            ),
                          ),
                          onTap: isSelectable
                              ? () {
                                  context
                                      .read<PpobCubit>()
                                      .setPaymentChannel(e);
                                  Navigator.pop(context);
                                }
                              : null,
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ImageCard(
                              image: e.logo ?? "",
                              height: 60,
                              width: 60,
                              radius: 10,
                              imageError: imageDefault,
                            ),
                          ),
                          subtitle: Text(
                            isSelectable
                                ? (e.paymentType == "APP"
                                    ? 'Saldo: ${Price.currency(e.user?.balance?.toDouble() ?? 0.0)}'
                                    : e.paymentType
                                            ?.replaceAll("_", " ")
                                            .replaceAll("GOPAY", "QRIS") ??
                                        "")
                                : "Minimal harga Rp50.000",
                            style: TextStyle(
                              fontSize: 13,
                              color: isSelectable ? Colors.grey : Colors.red,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: isSelectable
                                ? AppColors.secondaryColor
                                : Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}
