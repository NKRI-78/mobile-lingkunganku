import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/modules/profile/widget/show_dialog_transfer_management.dart';
import '../../../misc/colors.dart';

class TransferManagementSection extends StatelessWidget {
  const TransferManagementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.whiteColor, width: 1),
            ),
            child: Row(
              children: [
                /// **Gunakan Expanded agar teks tidak menyebabkan overflow**
                Expanded(
                  child: Text(
                    "Alihkan kepengurusan\nLingkungan",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 12,
                      fontFamily: 'Intel',
                      fontWeight: FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                SizedBox(width: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    /// Navigasi ke halaman pemilihan anggota
                    showTransferManagementDialog(context);
                  },
                  child: Text(
                    "Pilih Anggota",
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 14,
                      fontFamily: 'Intel',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
