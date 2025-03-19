// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'builder.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $onboardingRoute,
      $homeRoute,
    ];

RouteBase get $onboardingRoute => GoRouteData.$route(
      path: '/onboarding',
      factory: $OnboardingRouteExtension._fromState,
    );

extension $OnboardingRouteExtension on OnboardingRoute {
  static OnboardingRoute _fromState(GoRouterState state) => OnboardingRoute();

  String get location => GoRouteData.$location(
        '/onboarding',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/home',
      factory: $HomeRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'webview',
          factory: $WebViewRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'notification',
          factory: $NotificationRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'notification-sos',
              factory: $NotificationSosRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'settings',
          factory: $SettingsRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'waiting-payment',
          factory: $WaitingPaymentRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'iuran',
          factory: $IuranRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'iuran-history',
              factory: $IuranHistoryRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'ppob',
          factory: $PpobRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'event',
          factory: $EventRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'event-create',
              factory: $EventCreateRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'event-detail',
              factory: $EventDetailRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'news-detail',
          factory: $NewsDetailRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'news-update',
              factory: $NewsUpdateRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'show-more-news',
          factory: $ShowMoreNewsRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'news-create',
              factory: $NewsCreateRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'profile',
          factory: $ProfileRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'wallet',
              factory: $WalletRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'profile-update',
              factory: $ProfileUpdateRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'transfer-management',
              factory: $TransferManagementRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'iuran-info',
              factory: $IuranInfoRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'management',
          factory: $ManagementRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'management-detail',
              factory: $ManagementDetailRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'login',
          factory: $LoginRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'lupa-password',
              factory: $LupaPasswordRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'lupa-password-otp',
                  factory: $LupaPasswordOtpRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'lupa-password-change',
                      factory: $LupaPasswordChangeRouteExtension._fromState,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'register',
          factory: $RegisterRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'register-ketua',
              factory: $RegisterKetuaRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'register-otp',
                  factory: $RegisterOtpRouteExtension._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'register-warga',
              factory: $RegisterWargaRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'sos',
          factory: $SosRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'sos-detail',
              factory: $SosDetailRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'forum',
          factory: $ForumRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'forum-detail',
              factory: $ForumDetailRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'forum-create',
              factory: $ForumCreateRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'clipped-photo',
              factory: $ClippedPhotoRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'detail-video',
              factory: $DetailVideoPlayerRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => HomeRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WebViewRouteExtension on WebViewRoute {
  static WebViewRoute _fromState(GoRouterState state) => WebViewRoute(
        url: state.uri.queryParameters['url']!,
        title: state.uri.queryParameters['title']!,
      );

  String get location => GoRouteData.$location(
        '/home/webview',
        queryParams: {
          'url': url,
          'title': title,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NotificationRouteExtension on NotificationRoute {
  static NotificationRoute _fromState(GoRouterState state) =>
      NotificationRoute();

  String get location => GoRouteData.$location(
        '/home/notification',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NotificationSosRouteExtension on NotificationSosRoute {
  static NotificationSosRoute _fromState(GoRouterState state) =>
      NotificationSosRoute(
        idNotif: int.parse(state.uri.queryParameters['id-notif']!),
      );

  String get location => GoRouteData.$location(
        '/home/notification/notification-sos',
        queryParams: {
          'id-notif': idNotif.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsRouteExtension on SettingsRoute {
  static SettingsRoute _fromState(GoRouterState state) => SettingsRoute();

  String get location => GoRouteData.$location(
        '/home/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WaitingPaymentRouteExtension on WaitingPaymentRoute {
  static WaitingPaymentRoute _fromState(GoRouterState state) =>
      WaitingPaymentRoute(
        id: state.uri.queryParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/home/waiting-payment',
        queryParams: {
          'id': id,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $IuranRouteExtension on IuranRoute {
  static IuranRoute _fromState(GoRouterState state) => IuranRoute();

  String get location => GoRouteData.$location(
        '/home/iuran',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $IuranHistoryRouteExtension on IuranHistoryRoute {
  static IuranHistoryRoute _fromState(GoRouterState state) =>
      IuranHistoryRoute();

  String get location => GoRouteData.$location(
        '/home/iuran/iuran-history',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PpobRouteExtension on PpobRoute {
  static PpobRoute _fromState(GoRouterState state) => PpobRoute();

  String get location => GoRouteData.$location(
        '/home/ppob',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $EventRouteExtension on EventRoute {
  static EventRoute _fromState(GoRouterState state) => EventRoute();

  String get location => GoRouteData.$location(
        '/home/event',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $EventCreateRouteExtension on EventCreateRoute {
  static EventCreateRoute _fromState(GoRouterState state) => EventCreateRoute();

  String get location => GoRouteData.$location(
        '/home/event/event-create',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $EventDetailRouteExtension on EventDetailRoute {
  static EventDetailRoute _fromState(GoRouterState state) => EventDetailRoute(
        idEvent: int.parse(state.uri.queryParameters['id-event']!),
      );

  String get location => GoRouteData.$location(
        '/home/event/event-detail',
        queryParams: {
          'id-event': idEvent.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NewsDetailRouteExtension on NewsDetailRoute {
  static NewsDetailRoute _fromState(GoRouterState state) => NewsDetailRoute(
        newsId: int.parse(state.uri.queryParameters['news-id']!),
      );

  String get location => GoRouteData.$location(
        '/home/news-detail',
        queryParams: {
          'news-id': newsId.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NewsUpdateRouteExtension on NewsUpdateRoute {
  static NewsUpdateRoute _fromState(GoRouterState state) => NewsUpdateRoute(
        newsId: int.parse(state.uri.queryParameters['news-id']!),
      );

  String get location => GoRouteData.$location(
        '/home/news-detail/news-update',
        queryParams: {
          'news-id': newsId.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ShowMoreNewsRouteExtension on ShowMoreNewsRoute {
  static ShowMoreNewsRoute _fromState(GoRouterState state) =>
      ShowMoreNewsRoute();

  String get location => GoRouteData.$location(
        '/home/show-more-news',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NewsCreateRouteExtension on NewsCreateRoute {
  static NewsCreateRoute _fromState(GoRouterState state) => NewsCreateRoute();

  String get location => GoRouteData.$location(
        '/home/show-more-news/news-create',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProfileRouteExtension on ProfileRoute {
  static ProfileRoute _fromState(GoRouterState state) => ProfileRoute();

  String get location => GoRouteData.$location(
        '/home/profile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WalletRouteExtension on WalletRoute {
  static WalletRoute _fromState(GoRouterState state) => WalletRoute();

  String get location => GoRouteData.$location(
        '/home/profile/wallet',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProfileUpdateRouteExtension on ProfileUpdateRoute {
  static ProfileUpdateRoute _fromState(GoRouterState state) =>
      ProfileUpdateRoute();

  String get location => GoRouteData.$location(
        '/home/profile/profile-update',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TransferManagementRouteExtension on TransferManagementRoute {
  static TransferManagementRoute _fromState(GoRouterState state) =>
      TransferManagementRoute();

  String get location => GoRouteData.$location(
        '/home/profile/transfer-management',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $IuranInfoRouteExtension on IuranInfoRoute {
  static IuranInfoRoute _fromState(GoRouterState state) => IuranInfoRoute();

  String get location => GoRouteData.$location(
        '/home/profile/iuran-info',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ManagementRouteExtension on ManagementRoute {
  static ManagementRoute _fromState(GoRouterState state) => ManagementRoute();

  String get location => GoRouteData.$location(
        '/home/management',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ManagementDetailRouteExtension on ManagementDetailRoute {
  static ManagementDetailRoute _fromState(GoRouterState state) =>
      ManagementDetailRoute(
        userId: state.uri.queryParameters['user-id']!,
      );

  String get location => GoRouteData.$location(
        '/home/management/management-detail',
        queryParams: {
          'user-id': userId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => LoginRoute();

  String get location => GoRouteData.$location(
        '/home/login',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LupaPasswordRouteExtension on LupaPasswordRoute {
  static LupaPasswordRoute _fromState(GoRouterState state) =>
      LupaPasswordRoute();

  String get location => GoRouteData.$location(
        '/home/login/lupa-password',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LupaPasswordOtpRouteExtension on LupaPasswordOtpRoute {
  static LupaPasswordOtpRoute _fromState(GoRouterState state) =>
      LupaPasswordOtpRoute(
        email: state.uri.queryParameters['email']!,
      );

  String get location => GoRouteData.$location(
        '/home/login/lupa-password/lupa-password-otp',
        queryParams: {
          'email': email,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LupaPasswordChangeRouteExtension on LupaPasswordChangeRoute {
  static LupaPasswordChangeRoute _fromState(GoRouterState state) =>
      LupaPasswordChangeRoute(
        email: state.uri.queryParameters['email']!,
        otp: state.uri.queryParameters['otp']!,
      );

  String get location => GoRouteData.$location(
        '/home/login/lupa-password/lupa-password-otp/lupa-password-change',
        queryParams: {
          'email': email,
          'otp': otp,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $RegisterRouteExtension on RegisterRoute {
  static RegisterRoute _fromState(GoRouterState state) => RegisterRoute();

  String get location => GoRouteData.$location(
        '/home/register',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $RegisterKetuaRouteExtension on RegisterKetuaRoute {
  static RegisterKetuaRoute _fromState(GoRouterState state) =>
      RegisterKetuaRoute();

  String get location => GoRouteData.$location(
        '/home/register/register-ketua',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $RegisterOtpRouteExtension on RegisterOtpRoute {
  static RegisterOtpRoute _fromState(GoRouterState state) => RegisterOtpRoute(
        email: state.uri.queryParameters['email']!,
        isLogin: _$boolConverter(state.uri.queryParameters['is-login']!),
      );

  String get location => GoRouteData.$location(
        '/home/register/register-ketua/register-otp',
        queryParams: {
          'email': email,
          'is-login': isLogin.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $RegisterWargaRouteExtension on RegisterWargaRoute {
  static RegisterWargaRoute _fromState(GoRouterState state) =>
      RegisterWargaRoute();

  String get location => GoRouteData.$location(
        '/home/register/register-warga',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SosRouteExtension on SosRoute {
  static SosRoute _fromState(GoRouterState state) => SosRoute(
        isLoggedIn: _$boolConverter(state.uri.queryParameters['is-logged-in']!),
      );

  String get location => GoRouteData.$location(
        '/home/sos',
        queryParams: {
          'is-logged-in': isLoggedIn.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SosDetailRouteExtension on SosDetailRoute {
  static SosDetailRoute _fromState(GoRouterState state) => SosDetailRoute(
        isLoggedIn: _$boolConverter(state.uri.queryParameters['is-logged-in']!),
        sosType: state.uri.queryParameters['sos-type']!,
        message: state.uri.queryParameters['message']!,
      );

  String get location => GoRouteData.$location(
        '/home/sos/sos-detail',
        queryParams: {
          'is-logged-in': isLoggedIn.toString(),
          'sos-type': sosType,
          'message': message,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ForumRouteExtension on ForumRoute {
  static ForumRoute _fromState(GoRouterState state) => ForumRoute();

  String get location => GoRouteData.$location(
        '/home/forum',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ForumDetailRouteExtension on ForumDetailRoute {
  static ForumDetailRoute _fromState(GoRouterState state) => ForumDetailRoute(
        idForum: state.uri.queryParameters['id-forum']!,
      );

  String get location => GoRouteData.$location(
        '/home/forum/forum-detail',
        queryParams: {
          'id-forum': idForum,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ForumCreateRouteExtension on ForumCreateRoute {
  static ForumCreateRoute _fromState(GoRouterState state) => ForumCreateRoute();

  String get location => GoRouteData.$location(
        '/home/forum/forum-create',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ClippedPhotoRouteExtension on ClippedPhotoRoute {
  static ClippedPhotoRoute _fromState(GoRouterState state) => ClippedPhotoRoute(
        idForum: int.parse(state.uri.queryParameters['id-forum']!),
        indexPhoto: _$convertMapValue(
            'index-photo', state.uri.queryParameters, int.parse),
      );

  String get location => GoRouteData.$location(
        '/home/forum/clipped-photo',
        queryParams: {
          'id-forum': idForum.toString(),
          if (indexPhoto != null) 'index-photo': indexPhoto!.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DetailVideoPlayerRouteExtension on DetailVideoPlayerRoute {
  static DetailVideoPlayerRoute _fromState(GoRouterState state) =>
      DetailVideoPlayerRoute(
        urlVideo: state.uri.queryParameters['url-video']!,
      );

  String get location => GoRouteData.$location(
        '/home/forum/detail-video',
        queryParams: {
          'url-video': urlVideo,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

bool _$boolConverter(String value) {
  switch (value) {
    case 'true':
      return true;
    case 'false':
      return false;
    default:
      throw UnsupportedError('Cannot convert "$value" into a bool.');
  }
}

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}
