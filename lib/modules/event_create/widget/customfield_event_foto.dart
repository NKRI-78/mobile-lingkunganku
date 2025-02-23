import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_lingkunganku/modules/event_create/cubit/event_create_cubit.dart';
import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';

class CustomfieldEventFoto extends StatelessWidget {
  const CustomfieldEventFoto({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCreateCubit, EventCreateState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _showImagePicker(context),
              child: Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.secondaryColor, width: 1),
                ),
                child: state.fileImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(state.fileImage!,
                            fit: BoxFit.cover, width: 100, height: 100),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt,
                              color: AppColors.secondaryColor, size: 30),
                        ],
                      ),
              ),
            ),
            SizedBox(width: 12),
            Text("Foto Event",
                style: AppTextStyles.textStyle2.copyWith(
                  color: AppColors.secondaryColor,
                )),
          ],
        );
      },
    );
  }

  void _showImagePicker(BuildContext context) {
    final wargaCubit = context.read<EventCreateCubit>();

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return BlocProvider.value(
          value: wargaCubit,
          child: _ImagePickerBottomSheet(),
        );
      },
    );
  }
}

class _ImagePickerBottomSheet extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          leading: Icon(Icons.image, color: Colors.blueAccent),
          title: Text("Pilih dari Galeri"),
          onTap: () => _pickImage(context, ImageSource.gallery),
        ),
        ListTile(
          leading: Icon(Icons.camera_alt, color: Colors.green),
          title: Text("Gunakan Kamera"),
          onTap: () => _pickImage(context, ImageSource.camera),
        ),
        if (context.read<EventCreateCubit>().state.fileImage != null)
          ListTile(
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text("Hapus Foto"),
            onTap: () {
              context.read<EventCreateCubit>().copyState(
                  newState: context.read<EventCreateCubit>().state.copyWith(
                        fileImage: () => null,
                      ));
              Navigator.pop(context);
            },
          ),
      ],
    );
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      context.read<EventCreateCubit>().copyState(
          newState: context
              .read<EventCreateCubit>()
              .state
              .copyWith(fileImage: () => File(image.path)));
    }
    Navigator.pop(context);
  }
}
