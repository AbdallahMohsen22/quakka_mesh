import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_quakka/utill/cache_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'basic_constants.dart';
import 'core/network/notification_service.dart';
import 'core/routing/app_router.dart';
import 'core/shared_constabts.dart';
import 'guakko_app.dart';
import 'injection.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseMessagingBackgroundMessage (RemoteMessage message) async{

  if(message.notification != null){
    print("Some notification received onBackground success");
  }
  print("onBackground message success");
  print(message.data.toString());
  Constants.showToast(msg: "onBackground message success",
      gravity: ToastGravity.BOTTOM,
      color: Colors.green);
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyA6ruJRfrXdAjToK5yxL8b_dAZMmN9dffE',
        appId: '1:1057163177680:android:820c841d09ed86dd3d38d5',
        messagingSenderId: '1057163177680',
        projectId: 'quakkomesh',
        storageBucket: 'quakkomesh.appspot.com',
      )
  );
  // var token = await FirebaseMessaging.instance.getToken();
  // print("Token====>>> ${token}");

  await PushNotifications.init();  //initialize firebase messaging
  await PushNotifications.localNotiInit(); //initialize local notifications


  // background fcm
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundMessage);

  //on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if(message.notification != null){
      print("onMessageOpenedApp success");
      navigatorKey.currentState!.pushNamed("/message",arguments: message);
    }
  });

  //to handle foreground notification
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Get a message in foreground");

    if(message.notification != null){
      PushNotifications.shoSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData,
          sound: 'notification',
      );
    }
  });

  //for handling in terminated state
  final RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();

  if(message != null){
    print("Launched from terminated state");
    Future.delayed(Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed("/message",arguments: message);
    });
  }

  //when click on notification to open app
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print("onMessageOpenedApp success");
  //   print(event.data.toString());
  //   Constants.showToast(msg: "New Notification",
  //       gravity: ToastGravity.BOTTOM,
  //       color: Colors.green);
  // }).onError((error){
  //   print("onMessage error");
  // });
  // // foreground fcm
  // FirebaseMessaging.onMessage.listen((event) {
  //   print("onMessage success");
  //   print(event.data.toString());
  //   Constants.showToast(msg: "New Notification",
  //       gravity: ToastGravity.BOTTOM,
  //       color: Colors.green);
  // }).onError((error){
  //   print("onMessage error");
  // });

  initGetIt();
  final prefs = await SharedPreferences.getInstance();


  bool? isEnglish = prefs.getBool('isEnglish');
  isSignIn = prefs.getBool('isAuth');
  isAdmin = prefs.getBool("isAdmin");
  userId = prefs.getString("userId");
  adsPackageId = prefs.getInt(
    'adsPackageId',
  );
  servicePackageId = prefs.getInt(
    'servicePackageId',
  );
  if (kDebugMode) {
    print("isAuth =");
    print(isSignIn);
    print("isAdmin =");
    print(isAdmin);
    print("userId =");
    print(userId);
    // print("adsPackageId =");
    // print(adsPackageId);
    // print("servicePackageId =");
    // print(servicePackageId);
  }

  await CacheHelper.init();
  uId=CacheHelper.getData(key: "userId");
  print(uId);




  runApp(
    GuakkoApp(
      isEnglish: isEnglish,
      appRouter: AppRouter(),),
  );
}


class Get {
  static BuildContext? get context => navigatorKey.currentContext;
  static NavigatorState? get navigator => navigatorKey.currentState;
}

