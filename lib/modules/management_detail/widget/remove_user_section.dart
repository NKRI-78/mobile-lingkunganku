import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/misc/text_style.dart';

part '_show_dialog_remove.dart';

class RemoveUserSection extends StatelessWidget {
  const RemoveUserSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        //
        _showRemoveManagementMemberDialog(context);
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
              "Hapus Member Dari Grup",
              style: AppTextStyles.textProfileBold
                  .copyWith(color: AppColors.redColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
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
