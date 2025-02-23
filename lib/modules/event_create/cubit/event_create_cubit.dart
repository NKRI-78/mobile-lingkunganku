import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../misc/snackbar.dart';
import '../../../repositories/auth_repository/auth_repository.dart';
import '../../../repositories/event_repository/event_repository.dart';
import '../../../repositories/event_repository/models/event_model.dart';

part 'event_create_state.dart';

class EventCreateCubit extends Cubit<EventCreateState> {
  EventCreateCubit() : super(const EventCreateState());

  EventRepository repo = getIt<EventRepository>();
  AuthRepository repoUpload = getIt<AuthRepository>();

  void copyState({required EventCreateState newState}) {
    emit(newState);
  }

  bool submissionValidation(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    if (title.isEmpty) {
      ShowSnackbar.snackbar(
          context, "Harap masukkan Judul Event", '', AppColors.redColor);
      return false;
    } else if (description.isEmpty) {
      ShowSnackbar.snackbar(
          context, "Harap masukkan Deskripsi Event", '', AppColors.redColor);
      return false;
    }
    return true;
  }

  Future<void> createEvent() async {
    try {
      emit(state.copyWith(isLoading: true));
      final event = await repo.createEvent(
        title: state.title,
        description: state.description,
        startDate: state.startDate ?? DateTime.now().toLocal(),
        endDate: state.endDate ?? DateTime.now().toLocal(),
      );
      emit(state.copyWith(events: [event], isLoading: false));
      debugPrint("Event berhasil dibuat: $event");
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
      debugPrint("Gagal membuat event: $e");
      rethrow;
    }
  }

  Future<void> submit(BuildContext context) async {
    try {
      emit(state.copyWith(isLoading: true));

      // Validasi file gambar
      if (state.fileImage == null) {
        ShowSnackbar.snackbar(
            context, "Harap masukkan foto", '', AppColors.redColor);
        emit(state.copyWith(isLoading: false));
        return;
      }

      // Validasi form
      final bool isClear = submissionValidation(
        context,
        title: state.title,
        description: state.description,
      );
      if (!isClear) {
        emit(state.copyWith(isLoading: false));
        return;
      }

      // Upload image dan cek responsenya
      final List linkImage =
          await repoUpload.postMedia(folder: "images", media: state.fileImage!);
      final String imageUrl =
          (linkImage.isNotEmpty && linkImage.first.containsKey('url'))
              ? linkImage.first['url'] as String
              : '';

      if (imageUrl.isEmpty) {
        throw "Gagal mengunggah gambar";
      }

      // Konversi ID agar tidak menyebabkan error
      final int? neighborhoodId = int.tryParse(state.neighborhoodId ?? '');
      final int? userId = int.tryParse(state.userId ?? '');

      // Validasi tambahan
      // if (state.startDate == null || state.endDate == null) {
      //   throw "Tanggal mulai dan berakhir harus diisi";
      // }

      // Kirim data ke API
      final event = await repo.createEvent(
        title: state.title,
        description: state.description,
        startTime: state.startTime?.toIso8601String() ?? '',
        endTime: state.endTime?.toIso8601String() ?? '',
        address: state.address ?? '',
        startDate: state.startDate ?? DateTime.now().toLocal(),
        endDate: state.endDate ?? DateTime.now().toLocal(),
        neighborhoodId: neighborhoodId,
        userId: userId,
        imageUrl: imageUrl,
      );

      emit(state.copyWith(events: [event], isLoading: false));
      ShowSnackbar.snackbar(
          context, "Event berhasil dibuat", '', AppColors.secondaryColor);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
      ShowSnackbar.snackbar(
          context, "Gagal membuat event: $e", '', AppColors.redColor);
      debugPrint("Error saat submit event: $e");
      rethrow;
    }
  }
}
