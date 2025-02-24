import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/modules/event_create/cubit/event_create_cubit.dart';

class CustomFieldEventTime extends StatelessWidget {
  const CustomFieldEventTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _FieldStartTime()),
        SizedBox(width: 10),
        Expanded(child: _FieldEndTime()),
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
          selectedTime: state.startTime,
          onChanged: (time) {
            context.read<EventCreateCubit>().updateStartTime(time);
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
          selectedTime: state.endTime,
          onChanged: (time) {
            context.read<EventCreateCubit>().updateEndTime(time);
          },
          context: context,
        );
      },
    );
  }
}

Widget _buildTimePickerField({
  required String label,
  DateTime? selectedTime,
  required ValueChanged<DateTime> onChanged,
  required BuildContext context,
}) {
  TextEditingController controller = TextEditingController();
  controller.text =
      selectedTime != null ? DateFormat('HH:mm').format(selectedTime) : '';

  Future<void> selectTime() async {
    DatePicker.showTimePicker(
      context,
      showSecondsColumn: false,
      showTitleActions: true,
      onConfirm: (pickedTime) {
        final DateTime selected = DateTime(
          2000,
          1,
          1,
          pickedTime.hour,
          pickedTime.minute,
        ).toLocal();
        onChanged(selected);
      },
      currentTime: DateTime.now(),
      locale: LocaleType.id,
    );
  }

  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
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
            labelStyle: TextStyle(
              color: AppColors.buttonColor1,
              fontSize: 12,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.access_time,
                color: AppColors.secondaryColor,
                size: 28,
              ),
              onPressed: selectTime,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
          style: TextStyle(color: AppColors.textColor2),
        ),
      ),
    ),
  );
}
