import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:mobile_lingkunganku/misc/socket.dart';
import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../misc/snackbar.dart';
import '../../../repositories/payment_repository/models/payment_model.dart';
import '../../../repositories/payment_repository/payment_repository.dart';
import '../../app/bloc/app_bloc.dart';
import '../../notification/cubit/notification_cubit.dart';

part 'waiting_payment_state.dart';

class WaitingPaymentCubit extends Cubit<WaitingPaymentState> {
  WaitingPaymentCubit({required this.id}) : super(const WaitingPaymentState());

  final String id;

  SocketServices services = getIt<SocketServices>();

  PaymentRepository paymentRepo = PaymentRepository();

  Future<void> init(BuildContext context) async {
    try {
      emit(state.copyWith(loading: true));
      var payment = await paymentRepo.findPayment(id);

      emit(state.copyWith(payment: payment, loading: false));

      services.socket?.emit('joinWaitingPayment', payment.paymentNumber);

      services.socket?.on('payment:success', (data) async {
        print('OKE success bayar');
        emit(state.copyWith(loading: true));
        var payment = await paymentRepo.findPayment(id);
        emit(state.copyWith(payment: payment, loading: false));
      });
    } on SocketException catch (e) {
      if (!context.mounted) {
        return;
      }
      ShowSnackbar.snackbar(
          context, "Network Error: ${e.message}", '', AppColors.redColor);
    } on ClientException catch (e) {
      if (!context.mounted) {
        return;
      }
      ShowSnackbar.snackbar(
          context, "Client Error: ${e.message}", '', AppColors.redColor);
    } catch (e) {
      if (!context.mounted) {
        return;
      }
      ShowSnackbar.snackbar(
          context, "Unexpected Error: $e", '', AppColors.redColor);
    }
  }

  Future<void> onRefresh() async {
    try {
      var payment = await paymentRepo.findPayment(id);
      emit(state.copyWith(loading: false, payment: payment));
    } on SocketException {
      throw "Terjadi kesalahan jaringan";
    }
  }

  @override
  Future<void> close() {
    // services.socket?.off('payment:success');
    getIt<AppBloc>().add(InitialAppData());
    getIt<NotificationCubit>().fetchNotification();
    return super.close();
  }
}
