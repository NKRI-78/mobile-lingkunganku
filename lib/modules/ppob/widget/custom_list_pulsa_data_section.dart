import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/repositories/ppob_repository/models/pulsa_data_model.dart';

class CustomListPulsaDataSection extends StatelessWidget {
  final List<PulsaDataModel> pulsaData;

  const CustomListPulsaDataSection({super.key, required this.pulsaData});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final pulsa = pulsaData[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: const Icon(Icons.phone_android, color: Colors.blue),
              title: Text(
                pulsa.name ?? "Paket Tidak Diketahui",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Harga: Rp ${pulsa.price}"),
              trailing: ElevatedButton(
                onPressed: () {
                  // Tambahkan logika jika pengguna memilih pulsa
                },
                child: const Text("Pilih"),
              ),
            ),
          );
        },
        childCount: pulsaData.length,
      ),
    );
  }
}
