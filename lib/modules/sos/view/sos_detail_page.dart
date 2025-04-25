import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../misc/location.dart';
import '../../../widgets/background/custom_background.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../misc/text_style.dart';
import '../cubit/sos_cubit.dart';

class SosDetailPage extends StatelessWidget {
  const SosDetailPage({
    super.key,
    required this.isLoggedIn,
    required this.sosType,
    required this.message,
  });

  final bool isLoggedIn;
  final String sosType;
  final String message;

  @override
  Widget build(BuildContext context) {
    return SosDetailView(
      isLoggedIn: isLoggedIn,
      sosType: sosType,
      message: message,
    );
  }
}

class SosDetailView extends StatelessWidget {
  const SosDetailView({
    super.key,
    required this.isLoggedIn,
    required this.sosType,
    required this.message,
  });

  final bool isLoggedIn;
  final String sosType;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Kirim SOS',
          style: AppTextStyles.textStyle1,
        ),
        centerTitle: true,
        toolbarHeight: 100,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.buttonColor2,
            size: 24,
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          CustomBackground(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.redColor,
                  ),
                  child: const Icon(
                    Icons.warning,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(sosType, style: AppTextStyles.textStyle2),
                Container(
                  margin:
                      const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  child: ConfirmationSlider(
                      foregroundColor: AppColors.greyColor,
                      text: 'Geser untuk mengirim',
                      onConfirmation: () async {
                        debugPrint("Confirm");

                        var position = await determinePosition(context);

                        print('Position: $position');

                        if (context.mounted) {
                          buildAgreementDialog(context, sosType, message);
                        }
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future buildAgreementDialog(
      BuildContext context, String title, String message) {
    return showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (BuildContext context, Animation<double> double, _) {
        return BlocProvider.value(
          value: getIt<SosCubit>(),
          child: WillPopScope(
            onWillPop: () async => false,
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  height: 280,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              "assets/images/ic-alert.png",
                              width: 60.0,
                              height: 60.0,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: const EdgeInsets.only(top: 80.0),
                          child: const Text(
                            "Sebar Berita ?",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: const Text(
                              "Anda akan dihubungi pihak berwenang\napabila menyalahgunakan SOS\ntanpa tujuan dan informasi yang benar",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 30.0),
                              child: Builder(
                                builder: (BuildContext context) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(child: Container()),
                                      Expanded(
                                        flex: 5,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.redColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                          ),
                                          child: Text(
                                            "CANCEL",
                                            style: AppTextStyles.textDialog
                                                .copyWith(
                                                    color:
                                                        AppColors.whiteColor),
                                          ),
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Expanded(
                                        flex: 5,
                                        child: BlocBuilder<SosCubit, SosState>(
                                          builder: (context, state) {
                                            return ElevatedButton(
                                              onPressed: state.isLoading
                                                  ? null // Nonaktifkan tombol saat loading
                                                  : () {
                                                      context
                                                          .read<SosCubit>()
                                                          .sendSos(title,
                                                              message, context);
                                                    },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.secondaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12),
                                              ),
                                              child: state.isLoading
                                                  ? const SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: AppColors
                                                            .whiteColor,
                                                        strokeWidth: 2,
                                                      ),
                                                    )
                                                  : Text(
                                                      "OK",
                                                      style: AppTextStyles
                                                          .textDialog
                                                          .copyWith(
                                                              color: AppColors
                                                                  .whiteColor),
                                                    ),
                                            );
                                          },
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }
        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}
