import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../../../router/builder.dart';
import '../../../widgets/image/image_avatar.dart';
import '../cubit/forum_cubit.dart';

class ForumHeaderSection extends StatelessWidget {
  const ForumHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          ForumCreateRoute().go(context);
        },
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              // Avatar pengguna
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: ImageAvatar(
                    image: (context
                                    .read<ForumCubit>()
                                    .state
                                    .profile
                                    ?.profile
                                    ?.avatarLink !=
                                null &&
                            context
                                .read<ForumCubit>()
                                .state
                                .profile!
                                .profile!
                                .avatarLink!
                                .isNotEmpty)
                        ? context
                            .read<ForumCubit>()
                            .state
                            .profile!
                            .profile!
                            .avatarLink!
                        : "assets/images/default_avatar.png",
                    radius: 50,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Input Placeholder
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.greyColor.withValues(alpha: 0.2),
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
        ),
      ),
    );
  }
}
