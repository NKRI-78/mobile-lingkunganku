import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_lingkunganku/modules/home/view/home_page.dart';
import 'package:mobile_lingkunganku/modules/register/view/register_page.dart';
import '../modules/onboarding/view/onboarding_page.dart';

import '../modules/settings/view/settings_page.dart';

part 'builder.g.dart';

@TypedGoRoute<OnboardingRoute>(path: '/onboarding')
class OnboardingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OnboardingPage();
  }
}

@TypedGoRoute<HomeRoute>(path: '/home', routes: [
  TypedGoRoute<SettingsRoute>(path: 'settings'),
  TypedGoRoute<RegisterRoute>(path: 'register'),
])
class HomeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HomePage();
  }
}

class SettingsRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SettingsPage();
  }
}

class RegisterRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RegisterPage();
  }
}
