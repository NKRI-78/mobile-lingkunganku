import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../misc/http_client.dart';
import '../../../misc/injections.dart';
import '../../../repositories/auth_repository/models/user/user_model.dart';
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
  }

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

  FutureOr<void> _onSetUserLogout(SetUserLogout event, Emitter<AppState> emit) {
    emit(state.logout());
    getIt<ProfileCubit>().emit(ProfileState());
    getIt<HomeBloc>().emit(HomeState(selectedIndex: 0));
  }

  FutureOr<void> _onSetUserData(SetUserData event, Emitter<AppState> emit) {
    getIt<BaseNetworkClient>().addTokenToHeader(event.token);
    emit(state.copyWith(token: event.token, user: event.user));
    getIt<ProfileCubit>().getProfile();
    getIt<HomeBloc>().add(HomeInit());
    state.copyWith();
  }
}
