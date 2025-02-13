import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/repositories/management_repository/models/management_detail_member_model.dart';
import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../cubit/management_detail_cubit.dart';

part '_show_dialog_management_acces.dart';

class ManagementAccesSection extends StatelessWidget {
  final MemberData? member;
  const ManagementAccesSection({super.key, this.member});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Status Kepengurusan",
          style: AppTextStyles.textStyle1.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            print("Dialog muncul");

            _showManagementAccesDialog(
              context,
              (member?.secertary?.id?.toString() ??
                  member?.treasurer?.id?.toString()),
              member?.id.toString() ?? "",
            );
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
