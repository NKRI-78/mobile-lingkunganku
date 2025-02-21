import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../misc/colors.dart';
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
                SizedBox(
                  height: 100,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: families.map((family) {
                        String displayName = family.username.length > 10
                            ? family.username.substring(0, 10)
                            : family.username;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColors.secondaryColor,
                                child: ClipOval(
                                  child: family.profile?.avatarLink != null &&
                                          family.profile!.avatarLink!.isNotEmpty
                                      ? CachedNetworkImage(
                                          imageUrl: family.profile!.avatarLink!,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(
                                            color: AppColors.secondaryColor,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.person,
                                                  color: Colors.white),
                                        )
                                      : const Icon(Icons.person,
                                          color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 3),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 60,
                                ),
                                child: Text(
                                  displayName,
                                  style: AppTextStyles.textProfileNormal,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
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
