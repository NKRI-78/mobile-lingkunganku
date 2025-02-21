import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../cubit/register_warga_cubit.dart';

class CustomfieldWargaFoto extends StatelessWidget {
  const CustomfieldWargaFoto({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterWargaCubit, RegisterWargaState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _showImagePicker(context),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 1),
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
                          Icon(Icons.camera_alt, color: Colors.white, size: 30),
                        ],
                      ),
              ),
            ),
            SizedBox(width: 12),
            Text("Foto Profile",
                style: AppTextStyles.textStyle2.copyWith(
                  color: AppColors.secondaryColor,
                )),
          ],
        );
      },
    );
  }

  void _showImagePicker(BuildContext context) {
    final wargaCubit = context.read<RegisterWargaCubit>();

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
        if (context.read<RegisterWargaCubit>().state.fileImage != null)
          ListTile(
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text("Hapus Foto"),
            onTap: () {
              context.read<RegisterWargaCubit>().copyState(
                  newState: context.read<RegisterWargaCubit>().state.copyWith(
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
      context.read<RegisterWargaCubit>().copyState(
          newState: context
              .read<RegisterWargaCubit>()
              .state
              .copyWith(fileImage: () => File(image.path)));
    }
    Navigator.pop(context);
  }
}
