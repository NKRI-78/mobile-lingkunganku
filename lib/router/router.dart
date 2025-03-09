import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../modules/app/bloc/app_bloc.dart';
import 'builder.dart';

const GlobalObjectKey<NavigatorState> myNavigatorKey =
    GlobalObjectKey<NavigatorState>("myNavigator");

class MyRouter {
  static GoRouter init(AppBloc app) {
    return GoRouter(
      routes: $appRoutes,
      navigatorKey: myNavigatorKey,
      initialLocation: app.state.alreadyOnboarding
          ? HomeRoute().location
          : OnboardingRoute().location,
    );
  }
}
