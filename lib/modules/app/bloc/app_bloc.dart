import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../misc/http_client.dart';
import '../../../misc/injections.dart';
import '../../../repositories/auth_repository/models/user/user_model.dart';
import '../../../repositories/home_repository/home_repository.dart';
import '../../home/bloc/home_bloc.dart';
import '../../profile/cubit/profile_cubit.dart';

part 'app_bloc.g.dart';
part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial()) {
    on<FinishOnboarding>(_onFinishOnboarding);
    on<SetUserLogout>(_onSetUserLogout);
    on<SetUserData>(_onSetUserData);
    on<AppEvent>((event, emit) {});
    // on<GetBadgeNotif>(_onGetBadgeNotif);
  }

  HomeRepository repoHome = HomeRepository();

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    return _$AppStateFromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return _$AppStateToJson(state);
  }

  FutureOr<void> _onFinishOnboarding(
      FinishOnboarding event, Emitter<AppState> emit) {
    emit(state.copyWith(alreadyOnboarding: true));
  }

  Future<void> _onSetUserLogout(
      SetUserLogout event, Emitter<AppState> emit) async {
    try {
      repoHome.setFcm('');
      emit(state.logout());
      getIt<ProfileCubit>().emit(ProfileState());
      getIt<HomeBloc>().emit(HomeState(selectedIndex: 0));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  FutureOr<void> _onSetUserData(SetUserData event, Emitter<AppState> emit) {
    getIt<BaseNetworkClient>().addTokenToHeader(event.token);
    emit(state.copyWith(token: event.token, user: event.user));
    getIt<ProfileCubit>().getProfile();
    getIt<HomeBloc>().add(HomeInit());
    state.copyWith();
  }

  // FutureOr<void> _onGetBadgeNotif(GetBadgeNotif event, Emitter<AppState> emit) async {
  //   try {
  //     emit(state.copyWith(loadingNotif: true));
  //     NotificationCountModel badges =  await repoNotif.getBadgesNotif();
  //     emit(state.copyWith(badges: badges, loadingNotif: false));
  //     print("State : ${state.badges!.unreadCount}");
  //   } catch (e) {
  //     print("Error : $e");
  //   } finally {
  //     emit(state.copyWith(loadingNotif: false));
  //   }
  // }
}
