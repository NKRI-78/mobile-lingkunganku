part of '../view/wallet_page.dart';

class _FieldNominal extends StatelessWidget {
  final TextEditingController controller;
  const _FieldNominal({required this.controller});

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat("#,##0", "id_ID");
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        return TextField(
          controller: controller,
          keyboardType: TextInputType.phone,
          onTap: () {
            final ct = context.read<WalletCubit>();
            ct.copyState(newState: ct.state.copyWith(selectedCard: -1));
          },
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly, // Hanya angka
            LengthLimitingTextInputFormatter(15), // Maksimal 15 digit
          ],
          onChanged: (value) {
            final ct = context.read<WalletCubit>();

            // Bersihkan value agar hanya berisi angka
            String cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');

            // Batasi maksimal 15 digit
            if (cleanValue.length > 15) return;

            if (-1 > state.selectedCard) {
              controller.text = "";
            }

            if (cleanValue.isEmpty) {
              ct.copyState(
                  newState: ct.state.copyWith(amount: 0, selectedCard: -1));
              return;
            }

            int? number = int.tryParse(cleanValue);
            if (number != null) {
              String formatted = formatter.format(number);
              controller.value = TextEditingValue(
                text: formatted,
                selection: TextSelection.collapsed(offset: formatted.length),
              );

              ct.copyState(
                  newState: ct.state
                      .copyWith(amount: number.toDouble(), selectedCard: -1));
            }
          },
          decoration: const InputDecoration(
              fillColor: AppColors.whiteColor,
              filled: true,
              prefixText: "Rp ",
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(width: 2, color: AppColors.whiteColor),
                gapPadding: 2,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0.5),
              ),
              hintText: 'Isi nominal minimal 10.000',
              hintStyle: TextStyle(color: AppColors.greyColor)),
        );
      },
    );
  }
}
