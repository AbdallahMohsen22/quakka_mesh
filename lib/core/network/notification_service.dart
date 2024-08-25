import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';

class PushNotifications{
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //request Notification permission

  static Future init()async {

    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    //get the device token
    final token = await _firebaseMessaging.getToken();
    print("Divice token: <><><><><> ${token}");
  }

  //initialize local Notification
  static Future localNotiInit() async {
    //initialize the plugin
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
          '@mipmap/ic_launcher',
        );

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          // iOS: ,
          // linux: ,
        );

    //request Notification permission for android 13 or higher
    await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>
      ()!.requestNotificationsPermission();

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
    );
    print('Flutter Local Notification Plugin Initialized');

  }

  //on tap local notification in foreground
  static void onNotificationTap(NotificationResponse notificationResponse){

    navigatorKey.currentState!.pushNamed("/message",arguments: notificationResponse);
  }

  //show simple notification
  static Future shoSimpleNotification({
    required String title,
    required String body,
    required String payload,
    String? sound,
}) async{
     AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'your_channel_id',
            'your_channel_name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          sound: RawResourceAndroidNotificationSound('notification.wav'.split('.').first), // Android
          playSound: true,
        );
     NotificationDetails notificationDetails =
        NotificationDetails(
          android: androidNotificationDetails,
        );

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
   }
}