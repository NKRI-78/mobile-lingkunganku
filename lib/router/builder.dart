import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_lingkunganku/modules/ppob/view/ppob_page.dart';
import '../modules/iuran_info/view/iuran_info_page.dart';
import '../modules/iuran/view/iuran_page.dart';
import '../modules/iuran_history/view/iuran_history_page.dart';
import '../modules/notification/view/notification_page.dart';
import '../modules/notification/view/notification_sos_detail_page.dart';
import '../modules/sos/view/sos_detail_page.dart';
import '../modules/news_update/view/news_update_page.dart';
import '../modules/event/view/event_page.dart';
import '../modules/event_create/view/event_create_page.dart';
import '../modules/event_detail/view/event_detail_page.dart';
import '../modules/forum_create/view/forum_create_page.dart';
import '../modules/forum_detail/view/forum_detail_page.dart';
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
import '../modules/waiting_payment/view/waiting_payment_page.dart';
import '../modules/wallet/view/wallet_page.dart';
import '../modules/webview/view/webview.dart';
import '../widgets/pages/video/detail_video_player.dart';
import '../widgets/photo_view/clipped_photo_view.dart';

part 'builder.g.dart';

@TypedGoRoute<OnboardingRoute>(path: '/onboarding')
class OnboardingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OnboardingPage();
  }
}

@TypedGoRoute<HomeRoute>(path: '/home', routes: [
  TypedGoRoute<WebViewRoute>(path: 'webview'),
  TypedGoRoute<NotificationRoute>(path: 'notification', routes: [
    TypedGoRoute<NotificationSosRoute>(path: 'notification-sos'),
  ]),
  TypedGoRoute<SettingsRoute>(path: 'settings'),
  TypedGoRoute<WaitingPaymentRoute>(path: 'waiting-payment'),
  TypedGoRoute<IuranRoute>(path: 'iuran', routes: [
    TypedGoRoute<IuranHistoryRoute>(path: 'iuran-history'),
  ]),
  TypedGoRoute<PpobRoute>(path: 'ppob'),
  TypedGoRoute<EventRoute>(path: 'event', routes: [
    TypedGoRoute<EventCreateRoute>(path: 'event-create'),
    TypedGoRoute<EventDetailRoute>(path: 'event-detail'),
  ]),
  TypedGoRoute<NewsDetailRoute>(path: 'news-detail', routes: [
    TypedGoRoute<NewsUpdateRoute>(path: 'news-update'),
  ]),
  TypedGoRoute<ShowMoreNewsRoute>(path: 'show-more-news', routes: [
    TypedGoRoute<NewsCreateRoute>(path: 'news-create'),
  ]),
  TypedGoRoute<ProfileRoute>(path: 'profile', routes: [
    TypedGoRoute<WalletRoute>(path: 'wallet'),
    TypedGoRoute<ProfileUpdateRoute>(path: 'profile-update'),
    TypedGoRoute<TransferManagementRoute>(path: 'transfer-management'),
    TypedGoRoute<IuranInfoRoute>(path: 'iuran-info'),
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
  TypedGoRoute<SosRoute>(path: 'sos', routes: [
    TypedGoRoute<SosDetailRoute>(path: 'sos-detail'),
  ]),
  TypedGoRoute<ForumRoute>(path: 'forum', routes: [
    TypedGoRoute<ForumDetailRoute>(path: 'forum-detail'),
    TypedGoRoute<ForumCreateRoute>(path: 'forum-create'),
    TypedGoRoute<ClippedPhotoRoute>(path: 'clipped-photo'),
    TypedGoRoute<DetailVideoPlayerRoute>(path: 'detail-video'),
  ]),
])
class HomeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HomePage();
  }
}

class WebViewRoute extends GoRouteData {
  WebViewRoute({required this.url, required this.title});

  final String url;
  final String title;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return WebViewScreen(
      url: url,
      title: title,
    );
  }
}

class NotificationRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NotificationPage();
  }
}

class NotificationSosRoute extends GoRouteData {
  final int idNotif;

  NotificationSosRoute({required this.idNotif});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NotificationSosDetailPage(
      idNotif: idNotif,
    );
  }
}

class SettingsRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SettingsPage();
  }
}

class IuranRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return IuranPage();
  }
}

class IuranHistoryRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return IuranHistoryPage();
  }
}

class PpobRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PpobPage();
  }
}

class WaitingPaymentRoute extends GoRouteData {
  final String id;

  WaitingPaymentRoute({required this.id});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return WaitingPaymentPage(
      id: id,
    );
  }
}

class EventRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EventPage();
  }
}

class EventCreateRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EventCreatePage();
  }
}

class EventDetailRoute extends GoRouteData {
  final int idEvent;

  EventDetailRoute({required this.idEvent});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EventDetailPage(
      idEvent: idEvent,
    );
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

class WalletRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const WalletPage();
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

class IuranInfoRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return IuranInfoPage();
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

class SosDetailRoute extends GoRouteData {
  final bool isLoggedIn;
  final String sosType;
  final String message;

  SosDetailRoute({
    required this.isLoggedIn,
    required this.sosType,
    required this.message,
  });
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SosDetailPage(
      message: message,
      sosType: sosType,
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

class ForumDetailRoute extends GoRouteData {
  final String idForum;

  ForumDetailRoute({required this.idForum});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ForumDetailPage(idForum: idForum);
  }
}

class ForumCreateRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ForumCreatePage();
  }
}

class ClippedPhotoRoute extends GoRouteData {
  final int idForum;
  final int? indexPhoto;

  ClippedPhotoRoute({required this.idForum, this.indexPhoto});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ClippedPhotoPage(
      idForum: idForum,
      indexPhoto: indexPhoto ?? 0,
    );
  }
}

class DetailVideoPlayerRoute extends GoRouteData {
  final String urlVideo;

  DetailVideoPlayerRoute({required this.urlVideo});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DetailVideoPlayer(urlVideo: urlVideo);
  }
}
