import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/misc/helper.dart';
import 'package:upgrader/upgrader.dart';

import '../../../misc/injections.dart';
import '../../../misc/theme.dart';
import '../../../router/router.dart';
import '../bloc/app_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final app = getIt<AppBloc>();
    return BlocProvider<AppBloc>.value(
      value: app..add(InitialAppData()),
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => AppViewState();
}

class AppViewState extends State<AppView> {
  final router = MyRouter.init(getIt<AppBloc>());
  final _upgrader = Upgrader(
    countryCode: 'id',
    debugLogging: false,
    messages: UpgraderMessagesIndonesian(),
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (_, localState) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: baseTheme.copyWith(),
        routerConfig: router,
        builder: (context, child) {
          return UpgradeAlert(
            barrierDismissible: false,
            shouldPopScope: () => false,
            showIgnore: false,
            showLater: false,
            upgrader: _upgrader,
            showReleaseNotes: false,
            dialogStyle: Platform.isAndroid
                ? UpgradeDialogStyle.material
                : UpgradeDialogStyle.cupertino,
            navigatorKey: router.configuration.navigatorKey,
            child: child,
          );
        },
      );
    });
  }
}
