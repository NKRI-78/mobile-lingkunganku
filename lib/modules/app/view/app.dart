import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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
      value: app,
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (_, localState) {
      return MaterialApp.router(
        theme: baseTheme.copyWith(),
        routerConfig: router,
      );
    });
  }
}
