import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../modules/home/view/home_page.dart';
import '../modules/login/view/login_page.dart';
import '../modules/onboarding/view/onboarding_page.dart';
import '../modules/register/view/register_page.dart';
import '../modules/register_ketua/view/register_ketua_page.dart';
import '../modules/register_warga/view/register_warga_page.dart';
import '../modules/settings/view/settings_page.dart';
import '../modules/sos/view/sos_page.dart';

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
  TypedGoRoute<RegisterRoute>(path: 'register', routes: [
    TypedGoRoute<RegisterKetuaRoute>(path: 'register-ketua'),
    TypedGoRoute<RegisterWargaRoute>(path: 'register-warga'),
    TypedGoRoute<LoginRoute>(path: 'login'),
  ]),
  TypedGoRoute<SosRoute>(path: 'sos'),
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

class RegisterKetuaRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RegisterKetuaPage();
  }
}

class RegisterWargaRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RegisterWargaPage();
  }
}

class LoginRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LoginPage();
  }
}

class SosRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SosPage();
  }
}
