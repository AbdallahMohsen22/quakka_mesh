// import 'dart:convert';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:quokka_mesh/core/routing/routes.dart';
// import 'package:quokka_mesh/features/home/widgets/notification_screen.dart';
// import 'package:quokka_mesh/main.dart';
//
//
// Future<void> handleBackgroundMessage(RemoteMessage? message) async {
//
//   print("Title: ${message?.notification?.title}");
//   print("Body: ${message?.notification?.body}");
//   print("Payload: ${message?.data}");
// }
//
// class FirebaseNotifications{
//
//   //create instance of FBM
//   final _firebaseMessaging = FirebaseMessaging.instance;
//
//   //sort Notification category
//   final _androidChannel = const AndroidNotificationChannel(
//       'high_importance_channel',
//       'High Importance Notifications',
//     description: 'This channel is used for importance notifications',
//     importance: Importance.defaultImportance,
//   );
//   final _localNotifiations = FlutterLocalNotificationsPlugin();
//
//
//
// //handle notifications when received
//
//   void handleMessage(RemoteMessage? message) {
//     if (message == null) {
//       return;
//
//       // navigatorKey.currentState?.pushNamed(Routes.notificationScreen,arguments: message);
//
//     }else {
//       navigatorKey.currentState?.pushNamed(
//           Routes.notificationScreen,
//           arguments: message
//       );
//     }
//   }
//
//   Future initLocalNotifications() async {
//     const ios = IOSInitializationSettings();
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const settings = InitializationSettings(android: android,iOS: ios);
//
//     await _localNotifiations.initialize(
//       settings,
//       onSelectNotification: (payload) {
//         final message = RemoteMessage.fromMap(jsonDecode(payload!));
//         handleMessage(message);
//       },
//     );
//     final platform = _localNotifiations.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
//     await platform?.createNotificationChannel(_androidChannel);
//   }
//
//   Future<void> initPushNotifications() async {
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     FirebaseMessaging.instance.getInitialMessage().then(handleBackgroundMessage);
//
//     // FirebaseMessaging.onMessageOpenedApp.listen((handleBackgroundMessage){
//     //   navigatorKey.currentState?.pushNamed(
//     //     Routes.notificationScreen,
//     //   );
//     // });
//
//     // FirebaseMessaging.onMessage.listen((message) {
//     //   final notification = message.notification;
//     //   if (notification == null) return;
//     //
//     //   _localNotifiations.show(
//     //       notification.hashCode,
//     //       notification.title,
//     //       notification.body,
//     //       NotificationDetails(
//     //         android: AndroidNotificationDetails(
//     //             _androidChannel.id,
//     //             _androidChannel.name,
//     //           channelDescription: _androidChannel.description,
//     //            icon: '@mipmap/ic_launcher',
//     //         ),
//     //       ),
//     //     payload: jsonEncode(message.toMap()),
//     //   );
//     //
//     // });
//
//   }
//
//   //Initialize notif for this app or device
//
//   Future<void> initNotifications() async {
//     await _firebaseMessaging.requestPermission();
//
//     String? token = await _firebaseMessaging.getToken();
//
//     print("Token $token");
//
//     initPushNotifications();
//     initLocalNotifications();
//
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//   }
//
//
//
// }
//
