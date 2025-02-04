import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/modules/app/bloc/app_bloc.dart';

import '../../../misc/colors.dart';

class CustomHeaderAvatar extends StatelessWidget {
  const CustomHeaderAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final user = state.user;
        return Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.textColor1,
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Hi ${user?.profile?.fullname ?? 'User'},',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}
