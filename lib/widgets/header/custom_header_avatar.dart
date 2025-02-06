import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/modules/profile/cubit/profile_cubit.dart';
import '../../misc/injections.dart';
import '../../modules/app/bloc/app_bloc.dart';

import '../../../misc/colors.dart';

class CustomHeaderAvatarPage extends StatelessWidget {
  const CustomHeaderAvatarPage({super.key, required this.showText});
  final bool showText;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit()..getProfile(),
      child: CustomHeaderAvatar(
        showText: showText,
      ),
    );
  }
}

class CustomHeaderAvatar extends StatelessWidget {
  final bool showText;
  const CustomHeaderAvatar({super.key, required this.showText});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final appState = getIt<AppBloc>().state;
        final bool isLoggedIn = appState.isAlreadyLogin;
        final user = state.profile;

        return Column(
          children: [
            // Avatar User
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.textColor1,
              child: ClipOval(
                child: isLoggedIn
                    ? ClipOval(
                        child: Image.asset(
                          'assets/icons/user_avatar.png',
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: 60,
                        color: AppColors.whiteColor,
                      ),
              ),
            ),
            // Menampilkan teks setelah login
            if (showText) ...[
              const SizedBox(height: 10),
              Text(
                'Hi ${isLoggedIn ? (state.isLoading ? '-' : user?.profile?.fullname ?? 'User') : 'User'},',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ]
          ],
        );
      },
    );
  }
}
