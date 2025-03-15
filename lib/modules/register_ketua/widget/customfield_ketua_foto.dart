import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../cubit/register_ketua_cubit.dart';

class CustomfieldKetuaFoto extends StatelessWidget {
  const CustomfieldKetuaFoto({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterKetuaCubit, RegisterKetuaState>(
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
    final wargaCubit = context.read<RegisterKetuaCubit>();

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
          leading: Icon(Icons.image, color: AppColors.likeColor),
          title: Text("Pilih dari Galeri"),
          onTap: () => _pickImage(context, ImageSource.gallery),
        ),
        ListTile(
          leading: Icon(Icons.camera_alt, color: AppColors.secondaryColor),
          title: Text("Gunakan Kamera"),
          onTap: () => _pickImage(context, ImageSource.camera),
        ),
        if (context.read<RegisterKetuaCubit>().state.fileImage != null)
          ListTile(
            leading: Icon(Icons.delete, color: AppColors.redColor),
            title: Text("Hapus Foto"),
            onTap: () {
              context.read<RegisterKetuaCubit>().copyState(
                  newState: context.read<RegisterKetuaCubit>().state.copyWith(
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
      context.read<RegisterKetuaCubit>().copyState(
          newState: context
              .read<RegisterKetuaCubit>()
              .state
              .copyWith(fileImage: () => File(image.path)));
    }
    Navigator.pop(context);
  }
}
