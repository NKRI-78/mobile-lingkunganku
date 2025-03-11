import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/modules/iuran/widget/select_payment_channel.dart';

import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../repositories/iuran_repository/iuran_repository.dart';
import '../../../repositories/iuran_repository/models/iuran_model.dart';
import '../../../repositories/iuran_repository/models/payment_channel_model.dart';

part 'iuran_state.dart';

class IuranCubit extends Cubit<IuranState> {
  IuranCubit() : super(const IuranState());

  final IuranRepository repo = getIt<IuranRepository>();

  Future<void> getInvoice() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final invoice = await repo.getInvoice();
      emit(state.copyWith(
        isLoading: false,
        iuran: invoice,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Gagal memuat invoice: $e",
      ));
    }
  }

  Future<void> getPaymentChannel(BuildContext context) async {
    try {
      emit(state.copyWith(loadingChannel: true));
      var channels = await repo.getChannels();

      if (context.mounted) {
        showModalBottomSheet(
          context: context,
          builder: (_) => BlocProvider<IuranCubit>.value(
            value: context.read<IuranCubit>(),
            child: SelectPaymentChannel(),
          ),
        );
      }

      emit(state.copyWith(channels: channels, loadingChannel: false));
    } catch (e) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.redColor,
          content: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    } finally {
      emit(state.copyWith(loadingChannel: false));
    }
  }

  void setPaymentChannel(PaymentChannelModel e) {
    emit(state.copyWith(channel: e));
  }
}
