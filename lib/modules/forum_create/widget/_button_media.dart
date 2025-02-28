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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: CustomButton(
              text: 'Photo',
              onPressed: () async {
                await context.read<ForumCreateCubit>().uploadImg(context);
              },
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 5,
            child: CustomButton(
              text: 'Video',
              onPressed: () async {
                await context.read<ForumCreateCubit>().uploadVid(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
