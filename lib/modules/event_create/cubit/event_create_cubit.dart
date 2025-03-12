import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../router/builder.dart';
import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../misc/snackbar.dart';
import '../../../repositories/auth_repository/auth_repository.dart';
import '../../../repositories/event_repository/event_repository.dart';
import '../../../repositories/event_repository/models/event_model.dart';
import '../../event/cubit/event_cubit.dart';

part 'event_create_state.dart';

class EventCreateCubit extends Cubit<EventCreateState> {
  EventCreateCubit()
      : super(EventCreateState(
          startDate: DateTime.now(),
          endDate: DateTime.now(),
        ));

  EventRepository repo = getIt<EventRepository>();
  AuthRepository repoUpload = getIt<AuthRepository>();

  void copyState({required EventCreateState newState}) {
    emit(newState);
  }

  /// Fungsi untuk menggabungkan tanggal (`date`) dan waktu (`time`)
  DateTime combineDateAndTime(DateTime date, DateTime time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
      time.second,
    );
  }

  void updateStartDate(DateTime date) {
    final DateTime combinedDateTime =
        combineDateAndTime(date, state.startTime ?? DateTime.now());
    emit(state.copyWith(
        startDate: () => date, startTime: () => combinedDateTime));
  }

  void updateEndDate(DateTime date) {
    final DateTime combinedDateTime =
        combineDateAndTime(date, state.endTime ?? DateTime.now());
    emit(state.copyWith(endDate: () => date, endTime: () => combinedDateTime));
  }

  void updateStartTime(DateTime time) {
    final DateTime currentDate = state.startDate ?? DateTime.now();
    final DateTime combinedDateTime = combineDateAndTime(currentDate, time);
    emit(state.copyWith(startTime: () => combinedDateTime));
  }

  void updateEndTime(DateTime time) {
    final DateTime currentDate = state.endDate ?? DateTime.now();
    final DateTime combinedDateTime = combineDateAndTime(currentDate, time);
    emit(state.copyWith(endTime: () => combinedDateTime));
  }

  void selectStartDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: state.startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      updateStartDate(pickedDate);
    }
  }

  void selectEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: state.endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      updateEndDate(pickedDate);
    }
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
    } else if (state.startDate == null || state.endDate == null) {
      ShowSnackbar.snackbar(context, "Tanggal mulai dan berakhir harus diisi",
          '', AppColors.redColor);
      return false;
    } else if (state.startDate!.isAfter(state.endDate!)) {
      ShowSnackbar.snackbar(
          context,
          "Tanggal mulai tidak boleh setelah tanggal berakhir",
          '',
          AppColors.redColor);
      return false;
    }
    return true;
  }

  Future<void> submit(BuildContext context) async {
    try {
      emit(state.copyWith(isLoading: true));

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

      //  Pastikan tanggal tidak null
      final DateTime startDate = state.startDate ?? DateTime.now();
      final DateTime endDate = state.endDate ?? DateTime.now();

      if (startDate.isAfter(endDate)) {
        ShowSnackbar.snackbar(
            context,
            "Tanggal mulai tidak boleh setelah tanggal berakhir",
            '',
            AppColors.redColor);
        emit(state.copyWith(isLoading: false));
        return;
      }

      // Validasi file gambar
      if (state.fileImage == null) {
        ShowSnackbar.snackbar(
            context, "Harap masukkan Foto Event", '', AppColors.redColor);
        emit(state.copyWith(isLoading: false));
        return;
      }

      // Upload image
      final List linkImage =
          await repoUpload.postMedia(folder: "images", media: state.fileImage!);
      final String imageUrl =
          (linkImage.isNotEmpty && linkImage.first.containsKey('url'))
              ? linkImage.first['url'] as String
              : '';

      if (imageUrl.isEmpty) {
        throw "Gagal mengunggah gambar";
      }

      //  Konversi ID agar tidak menyebabkan error
      final int? neighborhoodId = int.tryParse(state.neighborhoodId ?? '');
      final int? userId = int.tryParse(state.userId ?? '');

      //  Buat event setelah validasi dan upload berhasil
      final event = await repo.createEvent(
        title: state.title,
        description: state.description,
        startTime: DateFormat("HH:mm").format(state.startTime!),
        endTime: DateFormat("HH:mm").format(state.endTime!),
        address: state.address ?? '',
        startDate: DateFormat("yyyy-MM-dd").format(startDate),
        endDate: DateFormat("yyyy-MM-dd").format(endDate),
        neighborhoodId: neighborhoodId,
        userId: userId,
        imageUrl: imageUrl,
      );

      //  Update state setelah event berhasil dibuat
      emit(state.copyWith(events: [event], isLoading: false));

      ShowSnackbar.snackbar(
          context, "Event berhasil dibuat", '', AppColors.secondaryColor);
      Future.microtask(() {
        EventRoute().go(context);
      });
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
      ShowSnackbar.snackbar(
          context, "Gagal membuat event: $e", '', AppColors.redColor);
      debugPrint("Error saat submit event: $e");
      rethrow;
    }
  }

  @override
  Future<void> close() {
    getIt<EventCubit>().fetchEvent();
    return super.close();
  }
}
