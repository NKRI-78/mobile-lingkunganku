import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/misc/pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../repositories/notification_repository/models/notification_model.dart';
import '../../../repositories/notification_repository/notification_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit()
      : super(NotificationState(pagination: Pagination.initial));

  NotificationRepository repo = NotificationRepository();

  static RefreshController refreshCtrl = RefreshController();

  Future<void> fetchNotification() async {
    try {
      PaginationModel<NotificationModel> data = await repo.getNotification();

      emit(state.copyWith(
        notif: data.list,
        nextPageNotif: data.pagination.currentPage,
        pagination: data.pagination,
      ));
    } catch (e) {
      emit(state.copyWith(loading: false));
      print(e);
    }
  }

  Future<void> refreshNotification() async {
    try {
      emit(state.copyWith(loading: true));
      PaginationModel<NotificationModel> data = await repo.getNotification();

      emit(state.copyWith(
        notif: data.list,
        nextPageNotif: data.pagination.currentPage,
        pagination: data.pagination,
        loading: false,
      ));
      refreshCtrl.refreshCompleted();
    } catch (e) {
      emit(state.copyWith(loading: false));
      print(e);
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> loadMoreNotification() async {
    try {
      PaginationModel<NotificationModel> data = await repo.getNotification(
          page: state.nextPageNotif == 1
              ? state.nextPageNotif + 1
              : state.nextPageNotif);

      emit(state.copyWith(
        notif: [...state.notif, ...data.list],
        nextPageNotif: data.pagination.currentPage + 1,
        pagination: data.pagination,
      ));

      print("State Paging : ${data.pagination.currentPage}");

      refreshCtrl.loadComplete();
    } catch (e) {
      debugPrint("error $e");
    } finally {
      refreshCtrl.loadComplete();
    }
  }

  // Future<void> readNotif(String idNotif) async {
  //   try {
  //     await repo.readNotif(idNotif);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<void> close() {
  //   getIt<AppBloc>().add(GetBadgeNotif());
  //   return super.close();
  // }
}
