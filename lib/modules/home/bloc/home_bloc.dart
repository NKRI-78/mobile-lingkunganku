import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../misc/injections.dart';
import '../../../misc/location.dart';
import '../../../repositories/home_repository/home_repository.dart';
import '../../../repositories/home_repository/models/data_pagination.dart';
import '../../../repositories/home_repository/models/news_model.dart';
import '../../../repositories/profile_repository/models/profile_model.dart';
import '../../../repositories/profile_repository/profile_repository.dart';
import '../../profile/cubit/profile_cubit.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.g.dart';

class HomeBloc extends HydratedBloc<HomeEvent, HomeState> {
  final HomeRepository repo;
  final ProfileCubit profileCubit;
  final ProfileRepository profileRepo = getIt<ProfileRepository>();

  HomeBloc(this.repo, this.profileCubit)
      : super(const HomeState(selectedIndex: 0)) {
    on<HomeInit>(_onHomeInit);
    on<HomeNavigate>(
        (event, emit) => emit(state.copyWith(selectedIndex: event.index)));
    on<LoadProfile>(_onLoadProfile);

    profileCubit.stream.listen((profileState) {
      if (profileState.profile != null) {
        add(LoadProfile());
      }
    });
  }

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    return _$HomeStateFromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    return _$HomeStateToJson(state);
  }

  Future<void> _onHomeInit(HomeInit event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true)); // Mulai dengan isLoading = true
    debugPrint("🚀 HomeInit started: Fetching news, profile, and location");

    try {
      await Future.wait([
        determinePosition(event.context!),
        _fetchNews(emit, isRefresh: true), // Fetch berita pertama kali
        _getProfile(emit),
      ]);
    } catch (e) {
      debugPrint("❌ Error in HomeInit: $e");
    }

    emit(state.copyWith(isLoading: false)); // Pastikan isLoading di-reset
    debugPrint("✅ HomeInit completed");
  }

  Future<void> _onLoadProfile(
      LoadProfile event, Emitter<HomeState> emit) async {
    _getProfile(emit);
  }

  Future<void> _fetchNews(Emitter<HomeState> emit,
      {bool isRefresh = false}) async {
    debugPrint("📰 Fetching news... isRefresh: $isRefresh");

    emit(state.copyWith(isLoading: true));

    try {
      final int nextPage = isRefresh ? 1 : state.nextPageNews;
      debugPrint("📡 Fetching news from API, page: $nextPage");

      DataPagination<NewsModel> newsData = await repo.getNews(page: nextPage);

      if (newsData.list.isEmpty) {
        debugPrint("⚠️ No news received from API!");
      } else {
        debugPrint("✅ News fetched: ${newsData.list.length} items");
      }

      emit(state.copyWith(
        news: isRefresh
            ? List.of(newsData.list)
            : [...state.news, ...newsData.list],
        nextPageNews: newsData.paginate.next ?? state.nextPageNews,
        isLoading: false,
      ));
    } catch (e) {
      debugPrint('❌ Error fetching news: $e');
    }
  }

  Future<void> _getProfile(Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final profile = await profileRepo.getProfile();

      if (!emit.isDone) {
        emit(state.copyWith(profile: profile));
      }
    } catch (e) {
      debugPrint('Error fetching profile: $e');
    } finally {
      if (!emit.isDone) {
        emit(state.copyWith(isLoading: false));
      }
    }
  }
}
