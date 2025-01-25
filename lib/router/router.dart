import 'package:go_router/go_router.dart';
import 'builder.dart';

import '../modules/app/bloc/app_bloc.dart';

class MyRouter {
  static GoRouter init(AppBloc app) {
    return GoRouter(
      routes: $appRoutes,
      initialLocation: OnboardingRoute().location,
    );
  }
}
