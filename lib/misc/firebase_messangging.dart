import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mobile_lingkunganku/firebase_options.dart';
import 'package:mobile_lingkunganku/router/router.dart';

class FirebaseMessagingMisc {
  static Future<void> init() async {
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) async {
        debugPrint('Pasklik');
        debugPrint("Data : ${message?.data}");
        await Future.delayed(const Duration(seconds: 2));
        // if (myNavigatorKey.currentContext != null && message?.data['type'] == "PAYMENT") {
        //   WaitingPaymentRoute(id: message?.data['id'] ?? "0").push(myNavigatorKey.currentContext!);
        // }
      },
    );

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint("Test comment id${message.data['title']}");
      debugPrint("Data notif: ${message.data}");
      await Future.delayed(const Duration(seconds: 2));
      // if (myNavigatorKey.currentContext != null && message.data['type'] == "PAYMENT") {
      //   WaitingPaymentRoute(id: message.data['id'] ?? "0").push(myNavigatorKey.currentContext!);
      // }
    });
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();

  // showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
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
    // sound: RawResourceAndroidNotificationSound('notification'),
    // playSound: true,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
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
    // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
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

void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {
  // display a dialog with the notification details, tap ok to go to another page
}

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    debugPrint("Test comment id ${json.decode(payload!)}");
    // if (json.decode(payload)['type'] == "PAYMENT") {
    //   WaitingPaymentRoute(id: json.decode(payload)['id']).push(myNavigatorKey.currentContext!);
    // }
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
            // sound: const RawResourceAndroidNotificationSound('notification'),
            // playSound: true,
          ),
        ),
        payload: json.encode(message.data));
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
