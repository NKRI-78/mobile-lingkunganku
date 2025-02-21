import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_lingkunganku/modules/news_update/view/news_update_page.dart';
import '../modules/news_create/view/news_create_page.dart';
import '../modules/forum/view/forum_page.dart';
import '../modules/management_detail/view/management_detail_page.dart';
import '../modules/show_more_news/view/show_more_news_page.dart';
import '../modules/transfer_management/view/transfer_management_page.dart';
import '../modules/management/view/management_page.dart';
import '../modules/profile_update/view/profile_update_page.dart';
import '../modules/news_detail/view/news_detail_page.dart';
import '../modules/profile/view/profile_page.dart';
import '../modules/register_otp/view/register_otp_page.dart';

import '../modules/home/view/home_page.dart';
import '../modules/login/view/login_page.dart';
import '../modules/lupa_password/view/lupa_password_page.dart';
import '../modules/lupa_password_change/view/lupa_password_change.dart';
import '../modules/lupa_password_otp/view/lupa_password_otp.dart';
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
  TypedGoRoute<NewsDetailRoute>(path: 'news-detail', routes: [
    TypedGoRoute<NewsUpdateRoute>(path: 'news-update'),
  ]),
  TypedGoRoute<ShowMoreNewsRoute>(path: 'show-more-news', routes: [
    TypedGoRoute<NewsCreateRoute>(path: 'news-create'),
  ]),
  TypedGoRoute<ProfileRoute>(path: 'profile', routes: [
    TypedGoRoute<ProfileUpdateRoute>(path: 'profile-update'),
    TypedGoRoute<TransferManagementRoute>(path: 'transfer-management'),
  ]),
  TypedGoRoute<ManagementRoute>(path: 'management', routes: [
    TypedGoRoute<ManagementDetailRoute>(path: 'management-detail'),
  ]),
  TypedGoRoute<LoginRoute>(path: 'login', routes: [
    TypedGoRoute<LupaPasswordRoute>(path: 'lupa-password', routes: [
      TypedGoRoute<LupaPasswordOtpRoute>(path: 'lupa-password-otp', routes: [
        TypedGoRoute<LupaPasswordChangeRoute>(path: 'lupa-password-change'),
      ])
    ]),
  ]),
  TypedGoRoute<RegisterRoute>(path: 'register', routes: [
    TypedGoRoute<RegisterKetuaRoute>(path: 'register-ketua', routes: [
      TypedGoRoute<RegisterOtpRoute>(path: 'register-otp'),
    ]),
    TypedGoRoute<RegisterWargaRoute>(path: 'register-warga'),
  ]),
  TypedGoRoute<SosRoute>(path: 'sos'),
  TypedGoRoute<ForumRoute>(path: 'forum'),
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

class NewsDetailRoute extends GoRouteData {
  final int newsId;

  NewsDetailRoute({
    required this.newsId,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NewsDetailPage(
      newsId: newsId,
    );
  }
}

class NewsUpdateRoute extends GoRouteData {
  final int newsId;

  NewsUpdateRoute({required this.newsId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NewsUpdatePage(
      newsId: newsId,
    );
  }
}

class ProfileRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProfilePage();
  }
}

class ShowMoreNewsRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ShowMoreNewsPage();
  }
}

class NewsCreateRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NewsCreatePage();
  }
}

class ProfileUpdateRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProfileUpdatePage();
  }
}

class TransferManagementRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TransferManagementPage();
  }
}

class ManagementRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ManagementPage();
  }
}

class ManagementDetailRoute extends GoRouteData {
  final String userId;

  ManagementDetailRoute({required this.userId});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ManagementDetailPage(
      userId: userId,
    );
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

class RegisterOtpRoute extends GoRouteData {
  final String email;
  final bool isLogin;

  RegisterOtpRoute({
    required this.email,
    required this.isLogin,
  });
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RegisterOtpPage(
      isLogin: isLogin,
      email: email,
    );
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

class LupaPasswordRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LupaPasswordPage();
  }
}

class LupaPasswordOtpRoute extends GoRouteData {
  final String email;

  LupaPasswordOtpRoute({required this.email});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LupaPasswordOtpPage(email: email);
  }
}

class LupaPasswordChangeRoute extends GoRouteData {
  final String email;
  final String otp;

  LupaPasswordChangeRoute({required this.email, required this.otp});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LupaPasswordChangePage(email: email, otp: otp);
  }
}

class SosRoute extends GoRouteData {
  final bool isLoggedIn;

  SosRoute({required this.isLoggedIn});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SosPage(
      isLoggedIn: isLoggedIn,
    );
  }
}

class ForumRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ForumPage();
  }
}
