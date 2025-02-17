import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../misc/theme.dart';
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
                // Avatar List
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: families.map((family) {
                      // debugPrint("Avatar URL: ${family.profile?.avatarLink}");
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.secondaryColor,
                          child: ClipOval(
                            child: family.profile?.avatarLink != null &&
                                    family.profile!.avatarLink!.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: family.profile!.avatarLink!,
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(
                                      color: AppColors.secondaryColor,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      avatarDefault,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(Icons.person, color: Colors.white),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 10),

                // Wrap digunakan untuk menampilkan teks agar tidak overflow
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 10,
                  runSpacing: 2,
                  children: families.map((family) {
                    return ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 100,
                      ),
                      child: Text(
                        family.username,
                        style: AppTextStyles.textProfileNormal,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.justify,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
