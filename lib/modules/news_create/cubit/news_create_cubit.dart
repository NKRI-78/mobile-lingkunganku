import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../misc/snackbar.dart';
import '../../../repositories/auth_repository/auth_repository.dart';
import '../../../repositories/news_repository/news_repository.dart';
import '../../show_more_news/cubit/show_more_news_cubit.dart';

part 'news_create_state.dart';

class NewsCreateCubit extends Cubit<NewsCreateState> {
  NewsCreateCubit() : super(const NewsCreateState());

  final NewsRepository newsRepo = getIt<NewsRepository>();
  final AuthRepository repo = getIt<AuthRepository>();

  bool submissionValidation(
    BuildContext context, {
    required String title,
    required String content,
    required File? imageFile,
  }) {
    if (title.isEmpty) {
      ShowSnackbar.snackbar(
          context, "Judul berita tidak boleh kosong", '', AppColors.redColor);
      return false;
    } else if (content.isEmpty) {
      ShowSnackbar.snackbar(
          context, "Isi berita tidak boleh kosong", '', AppColors.redColor);
      return false;
    } else if (imageFile == null) {
      ShowSnackbar.snackbar(
          context, "Harap pilih gambar untuk berita", '', AppColors.redColor);
      return false;
    }

    return true;
  }

  // Fungsi untuk memilih gambar dari galeri
  Future<void> pickImage(BuildContext context, ImageSource source) async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        final croppedFile = await _cropImage(pickedFile.path);
        if (croppedFile != null) {
          // Memperbarui state dengan gambar yang telah di-crop
          emit(state.copyWith(imageFile: () => File(croppedFile.path)));
        }
      }
    } catch (e) {
      debugPrint('Error picking/cropping image: $e');
    }
  }

  Future<CroppedFile?> _cropImage(String filePath) async {
    return await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Foto',
          toolbarColor: AppColors.secondaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.ratio16x9,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Crop Foto',
          aspectRatioLockEnabled: true,
        ),
      ],
    );
  }

  // Fungsi untuk membuat berita baru
  Future<void> createNews({
    required BuildContext context,
    required String title,
    required String content,
    required int userId,
    required int neighborhoodId,
    File? imageFile,
  }) async {
    try {
      if (!submissionValidation(context,
          title: title, content: content, imageFile: imageFile)) {
        return;
      }

      // Set state ke loading
      emit(state.copyWith(isLoading: true));

      // Upload gambar jika ada
      String imageUrl = "";
      if (imageFile != null) {
        final linkImage =
            await repo.postMedia(folder: "news_images", media: imageFile);

        final remapLink =
            linkImage.map((e) => {'url': e, 'type': "image"}).toList();
        imageUrl = remapLink[0]['url']['url'];
      }

      // Kirim data berita ke API
      await newsRepo.createNews(
        title: title,
        content: content,
        linkImage: imageUrl.isNotEmpty ? imageUrl : null,
        userId: userId,
        neighborhoodId: neighborhoodId,
      );

      // Set state ke sukses jika berhasil
      emit(state.copyWith(
        isLoading: false,
        successMessage: "Berita berhasil dibuat",
      ));
    } catch (error) {
      // Set state ke error jika gagal
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    getIt<ShowMoreNewsCubit>().fetchNews();
    return super.close();
  }
}
