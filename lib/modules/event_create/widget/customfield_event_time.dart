import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/modules/event_create/cubit/event_create_cubit.dart';

class CustomFieldEventTime extends StatelessWidget {
  const CustomFieldEventTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FieldStartTime(),
        SizedBox(height: 10),
        _FieldEndTime(),
      ],
    );
  }
}

class _FieldStartTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCreateCubit, EventCreateState>(
      buildWhen: (previous, current) => previous.startTime != current.startTime,
      builder: (context, state) {
        return _buildTimePickerField(
          label: 'Waktu Mulai',
          selectedTime: state.startTime != null
              ? TimeOfDay.fromDateTime(state.startTime!)
              : null,
          onChanged: (time) {
            // context.read<EventCreateCubit>().updateStartTime(time);
          },
          context: context,
        );
      },
    );
  }
}

class _FieldEndTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCreateCubit, EventCreateState>(
      buildWhen: (previous, current) => previous.endTime != current.endTime,
      builder: (context, state) {
        return _buildTimePickerField(
          label: 'Waktu Selesai',
          selectedTime: state.endTime != null
              ? TimeOfDay.fromDateTime(state.endTime!)
              : null,
          onChanged: (time) {
            // context.read<EventCreateCubit>().updateEndTime(time);
          },
          context: context,
        );
      },
    );
  }
}

Widget _buildTimePickerField({
  required String label,
  TimeOfDay? selectedTime,
  required ValueChanged<TimeOfDay> onChanged,
  required BuildContext context,
}) {
  TextEditingController controller = TextEditingController();
  controller.text = selectedTime != null
      ? selectedTime.format(context) // Format waktu yang mudah dibaca
      : '';

  Future<void> selectTime() async {
    TimeOfDay initialTime = selectedTime ?? TimeOfDay.now();
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null) {
      onChanged(picked);
    }
  }

  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.secondaryColor),
          ),
          child: TextFormField(
            controller: controller,
            readOnly: true,
            onTap: selectTime,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: AppColors.buttonColor1),
              suffixIcon: IconButton(
                icon: Icon(Icons.access_time, color: AppColors.secondaryColor),
                onPressed: selectTime,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            ),
            style: TextStyle(color: AppColors.textColor2),
          ),
        ),
      ),
    ),
  );
}
