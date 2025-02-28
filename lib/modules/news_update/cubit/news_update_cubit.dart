import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../misc/injections.dart';
import '../../show_more_news/cubit/show_more_news_cubit.dart';
import '../../../repositories/auth_repository/auth_repository.dart';
import '../../../repositories/news_repository/models/news_detail_model.dart';
import '../../../repositories/news_repository/news_repository.dart';

part 'news_update_state.dart';

class NewsUpdateCubit extends Cubit<NewsUpdateState> {
  NewsUpdateCubit() : super(const NewsUpdateState());

  NewsRepository newsRepo = getIt<NewsRepository>();
  AuthRepository repo = getIt<AuthRepository>();

  void copyState({required NewsUpdateState newState}) {
    emit(newState);
  }

  /// Mengambil detail berita berdasarkan ID
  Future<void> fetchDetailNews(int newsId) async {
    emit(state.copyWith(loading: true, errorMessage: null));

    try {
      final news = await newsRepo.getDetailNews(newsId);
      emit(state.copyWith(loading: false, updatedNews: news));
    } catch (e) {
      emit(state.copyWith(loading: false, errorMessage: e.toString()));
    }
  }

  /// Memperbarui berita dengan validasi
  Future<void> updateNews({
    required int newsId,
    required String title,
    required String content,
    File? imageFile,
  }) async {
    // **1. Validasi input**
    if (title.trim().isEmpty) {
      emit(state.copyWith(errorMessage: "Judul berita tidak boleh kosong"));
      return;
    }

    if (content.trim().isEmpty) {
      emit(state.copyWith(errorMessage: "Isi berita tidak boleh kosong"));
      return;
    }

    emit(state.copyWith(loading: true, success: false, errorMessage: null));

    try {
      String imageUrl = state.updatedNews?.data?.linkImage ?? "";

      // **2. Jika ada gambar baru, unggah gambar**
      if (imageFile != null) {
        try {
          final linkImage =
              await repo.postMedia(folder: "news_images", media: imageFile);

          if (linkImage.isNotEmpty) {
            imageUrl = linkImage.first['url'];
          } else {
            throw Exception("Gagal mengunggah gambar");
          }
        } catch (e) {
          emit(state.copyWith(
            loading: false,
            success: false,
            errorMessage: "Gagal mengunggah gambar: ${e.toString()}",
          ));
          return;
        }
      }

      // **3. Kirim update ke API**
      final updatedNews = await newsRepo.updateNews(
        newsId: newsId,
        title: title,
        content: content,
        linkImage: imageUrl,
      );

      emit(state.copyWith(
        loading: false,
        success: true,
        updatedNews: updatedNews,
      ));
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        success: false,
        errorMessage: "Terjadi kesalahan: ${e.toString()}",
      ));
    }
  }

  Future<void> removeNews(int newsId) async {
    try {
      emit(state.copyWith(loading: true, errorMessage: null));

      final success = await newsRepo.removeNews(newsId);

      if (success) {
        emit(state.copyWith(loading: false, success: true));
      } else {
        emit(state.copyWith(
          loading: false,
          success: false,
          errorMessage: "Gagal menghapus berita. Silakan coba lagi.",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        success: false,
        errorMessage: "Terjadi kesalahan: ${e.toString()}",
      ));
    }
  }

  @override
  Future<void> close() {
    getIt<ShowMoreNewsCubit>().fetchNews();
    return super.close();
  }
}
