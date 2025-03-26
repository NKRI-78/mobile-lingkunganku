import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../cubit/management_detail_cubit.dart';
import '../../../router/builder.dart';
import '../../../repositories/management_repository/models/management_detail_member_model.dart';

part '_show_dialog_remove.dart';

class RemoveUserSection extends StatelessWidget {
  final MemberData? member;
  const RemoveUserSection({super.key, this.member});

  @override
  Widget build(BuildContext context) {
    debugPrint("Member: ${member?.toJson()}");

    // Cek apakah user adalah CHIEF (gunakan toUpperCase() untuk menghindari kesalahan kapitalisasi)
    final bool isChief = (member?.roleApp?.toUpperCase() ?? "") == "CHIEF";

    return ElevatedButton(
      onPressed: (member == null || isChief)
          ? null
          : () {
              _showRemoveManagementMemberDialog(context, member!);
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Text(
              isChief ? "Hapus Member Tidak Dapat" : "Hapus Member Dari Grup",
              style: AppTextStyles.textProfileBold
                  .copyWith(color: AppColors.redColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          const Icon(
            size: 24,
            Icons.remove_circle,
            color: AppColors.redColor,
          ),
        ],
      ),
    );
  }
}
