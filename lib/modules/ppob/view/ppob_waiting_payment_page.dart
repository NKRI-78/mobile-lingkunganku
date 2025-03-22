import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:mobile_lingkunganku/modules/ppob/cubit/ppob_cubit.dart';

class PpobWaitingPaymentPage extends StatelessWidget {
  const PpobWaitingPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PpobCubit(),
      child: PpobWaitingPaymentView(),
    );
  }
}

class PpobWaitingPaymentView extends StatelessWidget {
  const PpobWaitingPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PpobCubit, PpobState>(
      builder: (context, state) {
        final paymentAccess = state.paymentAccess ?? "-";
        // final paymentType = state.paymentType ?? "Belum dipilih";
        // final orderId = state.orderId ?? "-";
        final totalPayment =
            state.selectedPulsaData?.price ?? 0 + state.adminFee;
        print(paymentAccess);

        return Scaffold(
          appBar: AppBar(title: const Text("Menunggu Pembayaran")),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Nomor Pembayaran Anda",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildPaymentBox(paymentAccess),
                const SizedBox(height: 15),
                // _buildDetailRow("Metode Pembayaran", paymentType),
                // _buildDetailRow("Order ID", orderId),
                _buildDetailRow("Total Pembayaran",
                    "Rp ${totalPayment.toStringAsFixed(0)}"),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Selesai"),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentBox(String paymentAccess) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: paymentAccess));
        // Tampilkan snackbar
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(paymentAccess,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Icon(Icons.copy, color: Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          Text(value,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
