import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/injections.dart';
import '../../../repositories/news_repository/models/news_detail_model.dart';
import '../../../repositories/news_repository/news_repository.dart';
import '../../../repositories/profile_repository/models/profile_model.dart';
import '../../../repositories/profile_repository/profile_repository.dart';

part 'news_detail_state.dart';

class NewsDetailCubit extends Cubit<NewsDetailState> {
  NewsDetailCubit() : super(const NewsDetailState()) {
    fetchProfile();
  }

  NewsRepository repo = getIt<NewsRepository>();
  ProfileRepository repoProfile = getIt<ProfileRepository>();

  void copyState({required NewsDetailState newState}) {
    emit(newState);
  }

  Future<void> fetchProfile() async {
    try {
      final profile = await repoProfile.getProfile();
      emit(state.copyWith(profile: profile));
      debugPrint("Profil berhasil dimuat: ${profile.roleApp}");
    } catch (e) {
      debugPrint("Gagal memuat profil: $e");
    }
  }

  Future<void> fetchDetailNews(int newsId) async {
    emit(state.copyWith(loading: true));
    try {
      final news = await repo.getDetailNews(newsId);
      emit(state.copyWith(
        news: news,
        idNews: newsId,
      ));
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(loading: false));
    }
  }
}
