import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/notification_repository/models/notification_detail_model.dart';
import '../../../misc/injections.dart';
import '../../../misc/pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../repositories/notification_repository/models/notification_model.dart';
import '../../../repositories/notification_repository/models/notificationv2_model.dart';
import '../../../repositories/notification_repository/notification_repository.dart';
import '../../app/bloc/app_bloc.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit()
      : super(NotificationState(pagination: Pagination.initial));

  NotificationRepository repo = NotificationRepository();

  static RefreshController refreshCtrl = RefreshController();

  Future<void> fetchDetailNotif(int idNotif) async {
    try {
      emit(state.copyWith(loading: true));
      final detail = await repo.getDetailNotif(idNotif);
      emit(state.copyWith(detail: detail, idNotif: idNotif));
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> fetchNotification() async {
    try {
      emit(state.copyWith(loading: true));
      fetchInboxNotifications();
      PaginationModel<NotificationModel> data = await repo.getNotification();

      emit(state.copyWith(
        notif: data.list,
        nextPageNotif: data.pagination.currentPage + 1,
        pagination: data.pagination,
        loading: false,
      ));
    } catch (e) {
      debugPrint("Error fetchNotification: $e");
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> fetchInboxNotifications() async {
    try {
      int userId = getIt<AppBloc>().state.profile?.id ?? 0;

      emit(state.copyWith(loading: true));
      List<NotificationV2Model> data =
          await repo.getInboxNotifications(userId.toString());

      emit(state.copyWith(
        inboxNotif: data,
        loading: false,
      ));
    } catch (e) {
      debugPrint("Error fetchInboxNotifications: $e");
      emit(state.copyWith(loading: false));
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

      refreshCtrl.loadComplete();
    } catch (e) {
      debugPrint("error $e");
    } finally {
      refreshCtrl.loadComplete();
    }
  }

  Future<void> readNotif(String idNotif) async {
    try {
      await repo.readNotif(idNotif);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> close() {
    getIt<AppBloc>().add(GetBadgeNotif());
    return super.close();
  }
}
