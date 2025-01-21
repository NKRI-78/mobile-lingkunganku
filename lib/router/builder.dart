import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_lingkunganku/modules/onboarding/view/onboarding_screen.dart';
import 'package:mobile_lingkunganku/modules/public/view/public_screen.dart';

part 'builder.g.dart';

@TypedGoRoute<OnboardingRoute>(path: '/onboarding')
class OnboardingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OnboardingScreen();
  }
}

@TypedGoRoute<PublicRoute>(path: '/public')
class PublicRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PublicScreen();
  }
}
