import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mobile_lingkunganku/repositories/profile_repository/profile_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../misc/injections.dart';
import '../../../repositories/home_repository/home_repository.dart';
import '../../../repositories/home_repository/models/data_pagination.dart';
import '../../../repositories/home_repository/models/news_model.dart';
import '../../../repositories/home_repository/models/pagination_model.dart';
import '../../../repositories/profile_repository/models/profile_model.dart';

part 'show_more_news_state.dart';

class ShowMoreNewsCubit extends Cubit<ShowMoreNewsState> {
  ShowMoreNewsCubit() : super(const ShowMoreNewsState()) {
    fetchProfile();
    fetchNews();
  }

  HomeRepository repo = getIt<HomeRepository>();
  ProfileRepository repoProfile = getIt<ProfileRepository>();

  static RefreshController newsRefreshCtrl = RefreshController();

  void copyState({required ShowMoreNewsState newState}) {
    emit(newState);
  }

  Future<void> fetchProfile() async {
    try {
      final profile = await repoProfile.getProfile();
      emit(state.copyWith(profile: profile));
    } catch (e) {
      debugPrint("Gagal memuat profil: $e");
    }
  }

  Future<void> fetchNews() async {
    try {
      emit(state.copyWith(loading: true));
      DataPagination<NewsModel> data = await repo.getNews();
      emit(
        state.copyWith(
            news: data.list,
            nextPageNews: data.paginate.next,
            newsPagination: data.paginate),
      );
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> onRefresh() async {
    DataPagination<NewsModel> data = await repo.getNews();

    emit(
      state.copyWith(
        news: data.list,
        nextPageNews: data.paginate.next,
        newsPagination: data.paginate,
      ),
    );
    newsRefreshCtrl.refreshCompleted();
  }

  FutureOr<void> loadMoreNews() async {
    try {
      DataPagination<NewsModel> data =
          await repo.getNews(page: state.nextPageNews);

      debugPrint('data news call ${state.news}');

      emit(state.copyWith(
          news: [...state.news, ...data.list],
          nextPageNews: data.paginate.next,
          newsPagination: data.paginate));
    } catch (e) {
      debugPrint("error news $e");
    } finally {
      newsRefreshCtrl.loadComplete();
    }
  }
}
