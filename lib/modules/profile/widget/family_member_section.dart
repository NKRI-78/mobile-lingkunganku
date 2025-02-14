import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../profile/models/families_model.dart';

class FamilyMemberSection extends StatelessWidget {
  final List<FamiliesModel> families;

  const FamilyMemberSection({super.key, required this.families});

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
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Anggota Keluarga',
                  style: AppTextStyles.textProfileNormal,
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: families.map((family) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.secondaryColor,
                          backgroundImage:
                              family.profile!.profile?.avatarLink != null
                                  ? NetworkImage(
                                      family.profile!.profile!.avatarLink!)
                                  : null,
                          child: family.profile!.profile?.avatarLink == null
                              ? const Icon(Icons.person, color: Colors.white)
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: families.map((family) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          family.profile?.profile?.fullname ?? "",
                          style: AppTextStyles.textProfileNormal,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      );
                    }).toList(),
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
