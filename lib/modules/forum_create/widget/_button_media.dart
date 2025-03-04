import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/button/custom_button.dart';
import '../cubit/forum_create_cubit.dart';

class ButtonMedia extends StatelessWidget {
  const ButtonMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              iconSize: 14,
              horizontalPadding: 20,
              verticalPadding: 10,
              text: 'Photo',
              icon: Icons.photo,
              onPressed: () async {
                await context.read<ForumCreateCubit>().uploadImg(context);
              },
            ),
            CustomButton(
              iconSize: 14,
              horizontalPadding: 20,
              verticalPadding: 10,
              text: 'Video',
              icon: Icons.videocam,
              onPressed: () async {
                await context.read<ForumCreateCubit>().uploadVid(context);
              },
            ),
            CustomButton(
              iconSize: 14,
              horizontalPadding: 15,
              verticalPadding: 10,
              text: 'Document',
              icon: Icons.insert_drive_file,
              onPressed: () async {
                await context.read<ForumCreateCubit>().uploadDoc(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
