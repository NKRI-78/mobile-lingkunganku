import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:slide_countdown/slide_countdown.dart';

import '../../../misc/colors.dart';
import '../../../misc/theme.dart';
import '../../../router/builder.dart';
import '../../../widgets/image/image_card.dart';
import '../../../widgets/pages/loading_page.dart';
import '../../../widgets/pages/page_success_payment.dart';
import '../cubit/waiting_payment_cubit.dart';
import '../widgets/qr_method_widget.dart';
import '../widgets/virtual_account_method_widget.dart';

class WaitingPaymentPage extends StatelessWidget {
  final String id;
  const WaitingPaymentPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WaitingPaymentCubit>(
      create: (context) => WaitingPaymentCubit(id: id)..init(context),
      child: const WaitingPaymentView(),
    );
  }
}

class WaitingPaymentView extends StatefulWidget {
  const WaitingPaymentView({super.key});

  @override
  State<WaitingPaymentView> createState() => _WaitingPaymentViewState();
}

class _WaitingPaymentViewState extends State<WaitingPaymentView> {
  late bool isExpired;

  @override
  void initState() {
    super.initState();
    isExpired = false;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Pembayaran",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: BlocBuilder<WaitingPaymentCubit, WaitingPaymentState>(
        builder: (context, state) {
          final targetDateTime = DateTime.parse(state.payment?.createdAt == null
                  ? DateTime.now().toString()
                  : state.payment!.createdAt!)
              .add(
            state.payment?.type == "VIRTUAL_ACCOUNT"
                ? const Duration(
                    days: 1,
                  )
                : const Duration(
                    minutes: 30,
                  ),
          );
          final duration = targetDateTime.difference(DateTime.now());

          if (state.loading) {
            return const SizedBox.expand(
              child: Center(
                child: LoadingPage(),
              ),
            );
          }
          if (state.payment == null) {
            return const SizedBox.shrink();
          }
          return RefreshIndicator(
            onRefresh: () async {
              await context.read<WaitingPaymentCubit>().onRefresh();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Status",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SlideCountdownSeparated(
                          duration: duration,
                          onDone: () {
                            setState(() {
                              isExpired = true;
                            });
                          },
                        ),
                      ],
                    ),
                    Text(
                      isExpired
                          ? "Pembayaran Kedaluwarsa"
                          : state.payment?.status == "WAITING_FOR_PAYMENT"
                              ? "Menunggu Pembayaran"
                              : "Pembayaran Berhasil",
                      style: TextStyle(
                        fontSize: 16,
                        color: state.payment?.status == "WAITING_FOR_PAYMENT" ||
                                isExpired
                            ? Colors.red
                            : AppColors.secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Metode Pembayaran",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ImageCard(
                            image: state.payment?.logoUrl ?? "-",
                            radius: 20,
                            width: 30,
                            height: 30,
                            imageError: imageDefault,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            state.payment?.name ?? "-",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    state.payment?.status == "WAITING_FOR_PAYMENT"
                        ? const Text(
                            "Batas akhir pembayaran",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Container(),
                    state.payment?.status == "WAITING_FOR_PAYMENT"
                        ? Text(
                            DateFormat().format(
                              DateTime.parse(state.payment?.createdAt ??
                                      DateTime.now().toString())
                                  .add(
                                state.payment?.type == "VIRTUAL_ACCOUNT"
                                    ? const Duration(
                                        days: 1,
                                      )
                                    : const Duration(
                                        minutes: 30,
                                      ),
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: 8,
                    ),
                    state.payment?.status == "PAID"
                        ? const PagePaymentStatus(
                            msg:
                                "Terima kasih anda sudah melakukan pembayaran pendaftaran siswa baru di Metro Hotel School",
                            img: "",
                          )
                        : isExpired
                            ? const PagePaymentStatus(
                                msg:
                                    "Mohon Maaf, Pembayaran anda sudah kedaluwarsa",
                                img: "",
                              )
                            : state.payment?.type == 'VIRTUAL_ACCOUNT'
                                ? VirtualAccountMethodWidget(
                                    payment: state.payment!,
                                  )
                                : QrMethodWidget(payment: state.payment!),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: AppColors.secondaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          HomeRoute().go(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home,
                                size: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Kembali ke Home")
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
