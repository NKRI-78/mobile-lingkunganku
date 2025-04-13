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
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagementDetailCubit, ManagementDetailState>(
      builder: (context, state) {
        final userId = state.memberDetail?.data?.id ?? 0;
        final role = state.memberDetail?.data?.roleApp ?? "";
        String formattedAmount =
            amountController.text.replaceAll(RegExp(r'[^0-9]'), '');

        print("📌 State Error: ${state.errorMessage}");
        print("📌 State Success: ${state.successMessage}");

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: AppColors.redColor),
            );
          } else if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.successMessage!),
                  backgroundColor: AppColors.secondaryColor),
            );
          }
        });

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
                        onChanged: (value) {
                          // 🔥 Perbaiki validasi langsung saat user mengetik
                          final formattedAmount =
                              value.replaceAll(RegExp(r'[^0-9]'), '');
                          context
                              .read<ManagementDetailCubit>()
                              .validateAmount(formattedAmount);
                        },
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
                      onPressed: () {
                        final userId = state.memberDetail?.data?.id ?? 0;
                        _showinvoiceDialog(
                          context,
                          userId,
                          formattedAmount,
                          descriptionController.text.trim(),
                        );
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
              maxLines: 1,
              maxLength: 50,
              controller: descriptionController,
              enabled: !state.hasUnpaidInvoice, // 🔥 Disable jika ada tagihan
              decoration: InputDecoration(
                hintText: "Keterangan Iuran",
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

  void _showinvoiceDialog(
      BuildContext context, int userId, String amount, String description) {
    final cubit = context.read<ManagementDetailCubit>();

    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: EdgeInsets.all(12),
          content: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/icons/chat_bubble.png',
                    height: 120,
                    width: 120,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Konfirmasi Iuran",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Pilih tindakan yang ingin Anda lakukan terhadap iuran pengguna ini.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            cubit.updateInvoice(
                              userId: userId,
                              amount: amount,
                              description: description,
                            );
                          },
                          child: const Text(
                            "Update",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            cubit.createInvoice(
                              userId: userId,
                              amount: amount,
                              description: description,
                            );
                          },
                          child: const Text(
                            "Buat Baru",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Positioned(
                top: -10,
                right: -10,
                child: IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textColor),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          // actionsAlignment: MainAxisAlignment.spaceEvenly,
          // actions: [
          //   SizedBox(
          //     width: double.infinity,
          //     child: CustomButton(
          //       text: "Update Iuran",
          //       onPressed: () {
          //         Navigator.of(context).pop();
          //         cubit.updateInvoice(
          //           userId: userId,
          //           amount: amount,
          //           description: description,
          //         );
          //       },
          //     ),
          //   ),
          //   SizedBox(
          //     width: double.infinity,
          //     child: CustomButton(
          //       text: "Buat Iuran",
          //       onPressed: () {
          //         Navigator.of(context).pop();
          //         cubit.createInvoice(
          //           userId: userId,
          //           amount: amount,
          //           description: description,
          //         );
          //       },
          //     ),
          //   ),
          // ],
        ),
      ),
    );
  }
}
