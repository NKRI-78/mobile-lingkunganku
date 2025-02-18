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
          path: 'settings',
          factory: $SettingsRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'detail-news',
          factory: $DetailNewsRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'show-more-news',
          factory: $ShowMoreNewsRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'profile',
          factory: $ProfileRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'profile-update',
              factory: $ProfileUpdateRouteExtension._fromState,
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
        ),
        GoRouteData.$route(
          path: 'forum',
          factory: $ForumRouteExtension._fromState,
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

extension $DetailNewsRouteExtension on DetailNewsRoute {
  static DetailNewsRoute _fromState(GoRouterState state) => DetailNewsRoute(
        newsId: int.parse(state.uri.queryParameters['news-id']!),
      );

  String get location => GoRouteData.$location(
        '/home/detail-news',
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
