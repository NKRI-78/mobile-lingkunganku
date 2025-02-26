import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/modules/event_create/cubit/event_create_cubit.dart';

class CustomFieldEventDate extends StatelessWidget {
  const CustomFieldEventDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _FieldStartDate()),
        SizedBox(width: 10),
        Expanded(child: _FieldEndDate()),
      ],
    );
  }
}

class _FieldStartDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCreateCubit, EventCreateState>(
      buildWhen: (previous, current) => previous.startDate != current.startDate,
      builder: (context, state) {
        return _buildDatePickerField(
          label: 'Tanggal Mulai',
          selectedDate: state.startDate,
          onChanged: (date) {
            context.read<EventCreateCubit>().updateStartDate(date);
          },
          context: context,
        );
      },
    );
  }
}

class _FieldEndDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCreateCubit, EventCreateState>(
      buildWhen: (previous, current) => previous.endDate != current.endDate,
      builder: (context, state) {
        return _buildDatePickerField(
          label: 'Tanggal Selesai',
          selectedDate: state.endDate,
          onChanged: (date) {
            context.read<EventCreateCubit>().updateEndDate(date);
          },
          context: context,
        );
      },
    );
  }
}

Widget _buildDatePickerField({
  required String label,
  DateTime? selectedDate,
  required ValueChanged<DateTime> onChanged,
  required BuildContext context,
}) {
  TextEditingController controller = TextEditingController();
  controller.text =
      selectedDate != null ? DateFormat('dd-MM-yyyy').format(selectedDate) : '';

  Future<void> selectDate() async {
    DateTime initialDate = selectedDate ?? DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.secondaryColor,
            hintColor: AppColors.secondaryColor,
            colorScheme: ColorScheme.light(
              primary: AppColors.secondaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onChanged(picked);
    }
  }

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
          controller: controller,
          readOnly: true,
          onTap: selectDate,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: AppColors.buttonColor1,
              fontSize: 14,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.calendar_today,
                color: AppColors.secondaryColor,
                size: 28,
              ),
              onPressed: selectDate,
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
