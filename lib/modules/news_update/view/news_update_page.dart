import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_lingkunganku/misc/theme.dart';
import 'package:mobile_lingkunganku/router/builder.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../widgets/button/custom_button.dart';
import '../cubit/news_update_cubit.dart';

class NewsUpdatePage extends StatelessWidget {
  const NewsUpdatePage({super.key, required this.newsId});

  final int newsId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsUpdateCubit()..fetchDetailNews(newsId),
      child: NewsUpdateView(newsId: newsId),
    );
  }
}

class NewsUpdateView extends StatefulWidget {
  const NewsUpdateView({super.key, required this.newsId});

  final int newsId;

  @override
  State<NewsUpdateView> createState() => _NewsUpdateViewState();
}

class _NewsUpdateViewState extends State<NewsUpdateView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  File? _selectedImage;
  String? _initialImageUrl;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  /// Fungsi untuk memilih gambar baru dari galeri
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  /// Fungsi untuk menghapus berita dengan konfirmasi
  void _deleteNews(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            "Hapus Berita",
            style: AppTextStyles.textDialog.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          content: const Text(
            "Apakah Anda yakin ingin menghapus berita ini?",
            textAlign: TextAlign.justify,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    child: Text(
                      "Batal",
                      style: AppTextStyles.textProfileBold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.redColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      context.read<NewsUpdateCubit>().removeNews(widget.newsId);
                      Navigator.pop(dialogContext);
                    },
                    child: Text(
                      "Hapus",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.textProfileBold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  /// Fungsi untuk mengirim update berita
  void _submitUpdate(BuildContext context) {
    context.read<NewsUpdateCubit>().updateNews(
          newsId: widget.newsId,
          title: _titleController.text,
          content: _contentController.text,
          imageFile: _selectedImage, // Gunakan gambar baru jika dipilih
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.3),
        title: Text(
          "Edit News",
          style:
              AppTextStyles.textStyle1.copyWith(color: AppColors.buttonColor2),
        ),
        centerTitle: true,
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: AppColors.buttonColor2, size: 32),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: AppColors.redColor,
              size: 32,
            ),
            onPressed: () {
              _deleteNews(context);
            },
          ),
        ],
      ),
      body: BlocConsumer<NewsUpdateCubit, NewsUpdateState>(
        listener: (context, state) {
          if (state.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("Berita berhasil diperbarui"),
                  backgroundColor: Colors.green),
            );
            ShowMoreNewsRoute().go(context);
          } else if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.updatedNews != null && _titleController.text.isEmpty) {
            _titleController.text = state.updatedNews!.data!.title!;
            _contentController.text = state.updatedNews!.data!.content!;
            _initialImageUrl = state.updatedNews!.data!.linkImage;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// **Gambar Berita**
                GestureDetector(
                  onTap: _pickImage,
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: _selectedImage != null
                          ? Image.file(
                              _selectedImage!,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            )
                          : _initialImageUrl != null
                              ? Image.network(
                                  _initialImageUrl!,
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                    imageDefault,
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.asset(
                                  imageDefault,
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// **TextField untuk Judul Berita**
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: "Judul Berita",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.blackColor,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.secondaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// **TextField untuk Isi Berita**
                TextField(
                  controller: _contentController,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: "Isi Berita",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.blackColor,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.secondaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// **Button Update Berita**
                SizedBox(
                  width: double.infinity,
                  child: state.loading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: "Update Berita",
                          onPressed: () {
                            _submitUpdate(context);
                          }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
