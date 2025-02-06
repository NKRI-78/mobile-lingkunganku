import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../misc/injections.dart';
import '../../modules/app/bloc/app_bloc.dart';

import '../../../misc/colors.dart';

class CustomHeaderAvatar extends StatelessWidget {
  final bool showText;
  const CustomHeaderAvatar({super.key, this.showText = true});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final appState = getIt<AppBloc>().state;
        final bool isLoggedIn = appState.isAlreadyLogin;
        final user = state.user;
        return Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.textColor1,
              child: isLoggedIn
                  ? ClipOval(
                      child: Image.asset(
                        'assets/icons/user_avatar.png',
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    )
                  : Icon(Icons.person, size: 60, color: AppColors.whiteColor),
            ),
            if (showText) ...[
              const SizedBox(height: 10),
              Text(
                'Hi ${user?.profile?.fullname ?? 'User'},',
                style: TextStyle(
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
