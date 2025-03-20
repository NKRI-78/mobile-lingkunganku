import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../cubit/management_detail_cubit.dart';

class PaymentSection extends StatefulWidget {
  const PaymentSection({super.key});

  @override
  State<PaymentSection> createState() => _PaymentSectionState();
}

class _PaymentSectionState extends State<PaymentSection> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    amountController.addListener(_formatAmount);
  }

  @override
  void dispose() {
    amountController.removeListener(_formatAmount);
    amountController.dispose();
    descriptionController.dispose();
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
        final userId = state.memberDetail?.data?.id ?? 0;
        final role = state.memberDetail?.data?.roleApp ?? "";

        print("INI USER TUJUAN : $userId");
        print("INI ROLE TUJUAN : $role");

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
                        enabled: !state
                            .hasUnpaidInvoice, // 🔥 Disable jika ada tagihan
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
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: state.hasUnpaidInvoice
                          ? null // 🔥 Disable tombol jika sudah ada tagihan
                          : () async {
                              try {
                                final amountValue = int.tryParse(
                                        amountController.text.replaceAll(
                                            RegExp(r'[^0-9]'), '')) ??
                                    0;
                                final description =
                                    descriptionController.text.trim();

                                if (amountValue <= 0) {
                                  throw Exception(
                                      "Nominal harus berupa angka yang valid!");
                                }
                                if (description.isEmpty) {
                                  throw Exception(
                                      "Deskripsi tidak boleh kosong!");
                                }

                                final userId =
                                    state.memberDetail?.data?.id ?? 0;

                                // 🔥 Cek ulang apakah masih ada invoice yang belum dibayar
                                final hasUnpaid = await context
                                    .read<ManagementDetailCubit>()
                                    .repoIuran
                                    .hasUnpaidInvoice(userId);

                                if (hasUnpaid) {
                                  context.read<ManagementDetailCubit>().emit(
                                      state.copyWith(hasUnpaidInvoice: true));
                                  throw Exception(
                                      "Pengguna masih memiliki invoice yang belum dibayar");
                                }

                                // 🔥 Buat invoice baru
                                await context
                                    .read<ManagementDetailCubit>()
                                    .createInvoice(
                                      userId: userId,
                                      amount: amountValue,
                                      description: description,
                                    );

                                if (!mounted) return;

                                // 🔥 Perbarui status `hasUnpaidInvoice`
                                await context
                                    .read<ManagementDetailCubit>()
                                    .checkUnpaidInvoice(userId);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: AppColors.secondaryColor,
                                    content: Text("Invoice berhasil dibuat"),
                                  ),
                                );

                                amountController.clear();
                                descriptionController.clear();
                              } catch (e) {
                                if (!mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: AppColors.redColor,
                                    content: Text(e
                                        .toString()
                                        .replaceAll("Exception: ", "")),
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
            const SizedBox(height: 10),
            TextField(
              maxLines: 2,
              controller: descriptionController,
              enabled: !state.hasUnpaidInvoice, // 🔥 Disable jika ada tagihan
              decoration: InputDecoration(
                hintText: "Deskripsi Iuran",
                hintStyle: AppTextStyles.textWelcome,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
