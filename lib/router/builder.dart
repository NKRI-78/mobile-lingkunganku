import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../modules/onboarding/view/onboarding_page.dart';
import '../modules/public/view/public_page.dart';

import '../modules/settings/view/settings_page.dart';

part 'builder.g.dart';

@TypedGoRoute<OnboardingRoute>(path: '/onboarding')
class OnboardingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OnboardingPage();
  }
}

@TypedGoRoute<PublicRoute>(path: '/public', routes: [
  TypedGoRoute<SettingsRoute>(path: 'settings'),
])
class PublicRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PublicPage();
  }
}

class SettingsRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SettingsPage();
  }
}
