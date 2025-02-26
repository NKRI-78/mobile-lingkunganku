import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/modules/forum/cubit/forum_cubit.dart';
import 'package:mobile_lingkunganku/router/builder.dart';
import '../../../widgets/image/image_avatar.dart';

class ForumHeaderSection extends StatelessWidget {
  const ForumHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ForumCreateRoute().go(context);
      },
      child: BlocBuilder<ForumCubit, ForumState>(
        builder: (context, state) {
          final imageUser = state.profile?.profile?.avatarLink;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar pengguna
                SizedBox(
                  width: 50,
                  height: 50,
                  child: ImageAvatar(
                    image: (imageUser != null && imageUser.isNotEmpty)
                        ? imageUser
                        : "assets/images/default_avatar.png",
                    radius: 50,
                  ),
                ),

                const SizedBox(width: 10),

                // Input Placeholder
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.greyColor.withOpacity(0.1),
                    ),
                    child: const Text(
                      "Menulis Sesuatu...",
                      style: TextStyle(
                        color: AppColors.blackNewsColor,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
