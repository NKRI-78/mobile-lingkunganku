import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../misc/colors.dart';
import '../cubit/profile_update_cubit.dart';
import '../widget/custom_textfield_name.dart';
import '../widget/custom_textfield_phone.dart';
import '../../../widgets/background/custom_background.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/header/custom_header_container.dart';

class ProfileUpdatePage extends StatelessWidget {
  const ProfileUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileUpdateCubit>(
      create: (context) => ProfileUpdateCubit(),
      child: const ProfielUpdateView(),
    );
  }
}

class ProfielUpdateView extends StatelessWidget {
  const ProfielUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileUpdateCubit, ProfileUpdateState>(
      listener: (context, state) {
        if (state.successMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage),
              backgroundColor: AppColors.secondaryColor,
            ),
          );
          Navigator.pop(context);
        }

        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppColors.redColor,
            ),
          );
        }
      },
      builder: (context, state) {
        final user = state.profile;
        return Scaffold(
          body: Stack(
            children: [
              CustomBackground(),
              Column(
                children: [
                  CustomHeaderContainer(
                    showAvatar: false,
                    displayText: '',
                    isLoggedIn: true,
                    showText: false,
                    title: 'Edit Profile',
                    onBackPressed: () => Navigator.pop(context),
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: state.fileImage != null
                                ? Image.file(
                                    state.fileImage!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    user?.profile?.avatarLink ??
                                        'https://via.placeholder.com/100',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          GestureDetector(
                            onTap: () => _showImagePicker(context),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomTextfieldName(),
                          CustomTextfieldPhone(),
                          SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              text: 'Save',
                              onPressed: () {
                                context
                                    .read<ProfileUpdateCubit>()
                                    .updateProfile(
                                      context: context,
                                      fullname: context
                                          .read<ProfileUpdateCubit>()
                                          .state
                                          .fullname,
                                      phone: context
                                          .read<ProfileUpdateCubit>()
                                          .state
                                          .phone,
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

void _showImagePicker(BuildContext context) {
  final wargaCubit = context.read<ProfileUpdateCubit>();

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
        if (context.read<ProfileUpdateCubit>().state.fileImage != null)
          ListTile(
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text("Hapus Foto"),
            onTap: () {
              context.read<ProfileUpdateCubit>().copyState(
                  newState: context.read<ProfileUpdateCubit>().state.copyWith(
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
      context.read<ProfileUpdateCubit>().copyState(
          newState: context.read<ProfileUpdateCubit>().state.copyWith(
                fileImage: () => File(image.path),
              ));
    }
    Navigator.pop(context);
  }
}
