import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/repositories/management_repository/models/management_member_model.dart';
import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';

part '_show_dialog_management_acces.dart';

class ManagementAccesSection extends StatelessWidget {
  final Members? member;
  const ManagementAccesSection({super.key, this.member});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Status Kepengurusan",
          style: AppTextStyles.textStyle1.copyWith(fontSize: 18),
        ),
        ElevatedButton(
          onPressed: () {
            //
            _showManagementAccesDialog(
                context, member?.secretary ?? member?.treasurer);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: Text(
            "Berikan Kepengurusan",
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
