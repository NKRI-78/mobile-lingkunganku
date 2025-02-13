import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package
import 'package:mobile_lingkunganku/repositories/management_repository/models/management_detail_member_model.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';

class JoinDateSection extends StatelessWidget {
  final MemberData? member;
  const JoinDateSection({super.key, this.member});

  /// Fungsi untuk mengubah format tanggal ISO menjadi "5 Februari 2025"
  String formatJoinDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return "Tidak Tersedia";
    }

    try {
      // Parsing ISO DateTime
      DateTime parsedDate = DateTime.parse(dateString).toLocal();

      // Format Indonesia
      return DateFormat("d MMMM yyyy", "id_ID").format(parsedDate);
    } catch (e) {
      print("Error parsing date: $e"); // Debugging
      return "Format Tanggal Salah";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              'Bergabung Sejak',
              style: AppTextStyles.textWelcome,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Flexible(
            child: Text(
              formatJoinDate(member?.createdAt), // Gunakan fungsi format
              style: AppTextStyles.textStyle2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
