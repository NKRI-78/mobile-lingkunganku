import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/modules/iuran/cubit/iuran_cubit.dart';

import '../../../misc/colors.dart';
import '../../../misc/price_currency.dart';
import '../../../misc/text_style.dart';
import '../../../misc/theme.dart';
import '../../../widgets/image/image_card.dart';

class SelectPaymentChannel extends StatelessWidget {
  const SelectPaymentChannel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IuranCubit, IuranState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Text(
                "Pilih Metode Pembayaran",
                style: AppTextStyles.textProfileBold
                    .copyWith(color: AppColors.blackColor, fontSize: 18),
              ),
              const SizedBox(height: 15),
              const Divider(),

              // List Metode Pembayaran
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.channels.length,
                  itemBuilder: (context, index) {
                    final e = state.channels[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      title: Text(
                        e.name == "Saldo"
                            ? "Lingkunganku Wallet"
                            : e.name ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        context.read<IuranCubit>().setPaymentChannel(e);
                        Navigator.pop(context);
                        //
                      },
                      leading: ImageCard(
                        image: e.logo ?? "",
                        height: 70,
                        width: 70,
                        radius: 10,
                        imageError: imageDefault,
                      ),
                      subtitle: Text(
                        e.paymentType == "APP"
                            ? 'Saldo: ${Price.currency(e.user?.balance?.toDouble() ?? 0.0)}'
                            : e.paymentType
                                    ?.replaceAll("_", " ")
                                    .replaceAll("GOPAY", "QRIS") ??
                                "",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
