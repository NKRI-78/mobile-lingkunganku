import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../repositories/management_repository/models/management_detail_member_model.dart';
import '../../management/cubit/management_cubit.dart';
import '../cubit/management_detail_cubit.dart';

part '_show_dialog_management_acces.dart';

class ManagementAccesSection extends StatelessWidget {
  final MemberData? member;
  const ManagementAccesSection({super.key, this.member});

  @override
  Widget build(BuildContext context) {
    final bool isAlreadyPromoted =
        (member?.secretary?.id != null) || (member?.treasurer?.id != null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Status Kepengurusan",
          style: AppTextStyles.textStyle1.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: isAlreadyPromoted
              ? null
              : () {
                  print("Dialog muncul");
                  _showManagementAccesDialog(
                    context,
                    (member?.secretary?.id?.toString() ??
                        member?.treasurer?.id?.toString()),
                    member?.id.toString() ?? "",
                  );

                  try {
                    context.read<ManagementCubit>().fetchManagementMembers();
                  } catch (e) {
                    print(
                        "Error: ManagementCubit tidak ditemukan dalam context.");
                  }
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: isAlreadyPromoted
                ? Colors.grey.shade400
                : AppColors.secondaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: Text(
            isAlreadyPromoted
                ? "Kepengurusan Telah Diberikan"
                : "Berikan Kepengurusan",
            style: AppTextStyles.textProfileBold.copyWith(
              color: AppColors.whiteColor,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        )
      ],
    );
  }
}
