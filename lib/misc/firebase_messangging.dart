import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mobile_lingkunganku/router/builder.dart';
import 'package:mobile_lingkunganku/router/router.dart';
import '../firebase_options.dart';

class FirebaseMessagingMisc {
  static Future<void> init() async {
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) async {
        debugPrint('Pasklik');
        debugPrint("Data : ${message?.data}");
        await Future.delayed(const Duration(seconds: 2));

        if (myNavigatorKey.currentContext != null) {
          final type = message?.data['type'];
          final id = message?.data['id'] ?? "0";

          if (type == "PAYMENT") {
            WaitingPaymentRoute(id: id).push(myNavigatorKey.currentContext!);
          } else if (type == "SOS") {
            NotificationSosRoute(idNotif: id)
                .push(myNavigatorKey.currentContext!);
          } else if (type == "BROADCAST") {
            NotificationSosRoute(idNotif: id)
                .push(myNavigatorKey.currentContext!);
          }
        }
      },
    );

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint("Test comment id${message.data['title']}");
      debugPrint("Data notif: ${message.data}");
      await Future.delayed(const Duration(seconds: 2));

      if (myNavigatorKey.currentContext != null) {
        final type = message.data['type'];
        final id = message.data['id'] ?? "0";

        if (type == "PAYMENT") {
          WaitingPaymentRoute(id: id).push(myNavigatorKey.currentContext!);
        } else if (type == "SOS") {
          NotificationSosRoute(idNotif: id)
              .push(myNavigatorKey.currentContext!);
        } else if (type == "BROADCAST") {
          NotificationRoute().push(myNavigatorKey.currentContext!);
        }
      }
    });
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();

  debugPrint('Handling a background message ${message.data}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }

  channel = const AndroidNotificationChannel(
    'lingkunganku_notif', // id
    'Lingkunganku Notification', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
  );

  const LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(defaultActionName: 'Open notification');
  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);

  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
}

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  if (payload != null) {
    debugPrint("Test comment id ${json.decode(payload)}");

    final data = json.decode(payload);
    final type = data['type'];
    final id = int.tryParse(data['id'].toString()) ?? 0;

    if (type == "PAYMENT") {
      WaitingPaymentRoute(id: id.toString())
          .push(myNavigatorKey.currentContext!);
    } else if (type == "SOS") {
      NotificationSosRoute(idNotif: id).push(myNavigatorKey.currentContext!);
    } else if (type == "BROADCAST") {
      NotificationRoute().push(myNavigatorKey.currentContext!);
    }
  }
}

void showFlutterNotification(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  if (notification != null && android != null && !kIsWeb) {
    debugPrint("Channel name : ${notification.title}");

    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@drawable/ic_notification',
          ),
        ),
        payload: json.encode(message.data));
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
