import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/management_detail_cubit.dart';
import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';

class PaymentSection extends StatefulWidget {
  const PaymentSection({super.key});

  @override
  State<PaymentSection> createState() => _PaymentSectionState();
}

class _PaymentSectionState extends State<PaymentSection> {
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    amountController.addListener(_formatAmount);
  }

  @override
  void dispose() {
    amountController.removeListener(_formatAmount);
    amountController.dispose();
    super.dispose();
  }

  void _formatAmount() {
    String text = amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.isNotEmpty) {
      amountController.value = TextEditingValue(
        text: "Rp $text",
        selection: TextSelection.collapsed(offset: "Rp $text".length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagementDetailCubit, ManagementDetailState>(
      builder: (context, state) {
        final userId = state.memberDetail?.data?.id;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Buat Iuran",
                style: AppTextStyles.textStyle1.copyWith(fontSize: 18)),
            const SizedBox(height: 10),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Rp 0",
                          hintStyle: AppTextStyles.textWelcome,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        try {
                          final amountValue = int.tryParse(amountController.text
                                  .replaceAll(RegExp(r'[^0-9]'), '')) ??
                              0;

                          print(
                              "User ID: ${userId ?? 0}, Amount: $amountValue");

                          if (amountValue <= 0) {
                            throw Exception(
                                "Nominal harus berupa angka yang valid!");
                          }

                          final hasUnpaid = await context
                              .read<ManagementDetailCubit>()
                              .repoIuran
                              .hasUnpaidInvoice(userId ?? 0);

                          if (hasUnpaid) {
                            throw Exception(
                                "Pengguna masih memiliki invoice yang belum dibayar");
                          }

                          await context
                              .read<ManagementDetailCubit>()
                              .createInvoice(
                                userId: userId ?? 0,
                                amount: amountValue,
                                description: "Tagihan Bulanan",
                              );

                          if (!mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.secondaryColor,
                              content: Text("Invoice berhasil dibuat"),
                            ),
                          );

                          amountController.clear();
                        } catch (e) {
                          if (!mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.redColor,
                              content: Text(
                                  e.toString().replaceAll("Exception: ", "")),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.send, color: Colors.white),
                      label: Text(
                        "Submit",
                        style: AppTextStyles.textProfileBold,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
