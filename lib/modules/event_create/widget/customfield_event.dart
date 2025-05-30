import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../cubit/event_create_cubit.dart';

class CustomfieldEvent extends StatelessWidget {
  const CustomfieldEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FieldTitle(),
        SizedBox(height: 5),
        _FieldDescription(),
      ],
    );
  }
}

class _FieldTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCreateCubit, EventCreateState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        return _buildTextFormField(
          label: 'Judul Event',
          onChanged: (value) {
            context.read<EventCreateCubit>().copyState(
                newState: context
                    .read<EventCreateCubit>()
                    .state
                    .copyWith(title: value));
          },
        );
      },
    );
  }
}

class _FieldDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCreateCubit, EventCreateState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return _buildTextFormField(
          maxLines: 5,
          label: 'Deskripsi Event',
          onChanged: (value) {
            context.read<EventCreateCubit>().copyState(
                newState: context
                    .read<EventCreateCubit>()
                    .state
                    .copyWith(description: value));
          },
        );
      },
    );
  }
}

Widget _buildTextFormField({
  required String label,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
  int maxLines = 1,
  required ValueChanged<String> onChanged,
  int? maxLength,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.secondaryColor),
        ),
        child: TextFormField(
          maxLength: maxLength,
          maxLines: maxLines,
          keyboardType: keyboardType,
          obscureText: obscureText,
          textCapitalization: TextCapitalization.words,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: AppColors.buttonColor1,
              fontSize: 12,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          ),
          style: TextStyle(color: AppColors.textColor2),
        ),
      ),
    ),
  );
}
