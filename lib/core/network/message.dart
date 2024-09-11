import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shimmer/shimmer.dart';

import '../../features/home/home_cubit/home_cubit.dart';
import '../../utill/color_resources.dart';


class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  Map<String, dynamic> payload = {};
  late final FirebaseMessaging _firebaseMessaging;

  @override
  void initState() {
    super.initState();

    _firebaseMessaging = FirebaseMessaging.instance;

    // Initialize Firebase Messaging and Local Notifications
    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _handleMessage(message);
      }
    });
  }

  void _handleMessage(RemoteMessage message) {
    if (mounted) {
      setState(() {
        payload.addAll(message.data);
      });
    }
  }

  void _handleNotificationResponse(NotificationResponse response) {
    if (mounted) {
      setState(() {
        payload.addAll(jsonDecode(response.payload!));
      });
    }
  }

  @override
  void dispose() {
    // Cleanup listeners
    FirebaseMessaging.onMessage.listen(null).cancel();
    FirebaseMessaging.onMessageOpenedApp.listen(null).cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments;

    // for background and terminated state
    if (data is RemoteMessage) {
      _handleMessage(data);
    }

    // for foreground state
    if (data is NotificationResponse) {
      _handleNotificationResponse(data);
    }

    return Scaffold(
      appBar: AppBar(
        title: Shimmer.fromColors(
          baseColor: ColorResources.apphighlightColor,
          highlightColor: ColorResources.apphighlightColor,
          child: Text(
            HomeCubit.get(context).isArabic ? "الاشعارات" : 'Notification',
          ),
        ),
      ),
      // body: ListView.builder(
      //   itemCount: payload.length,
      //   itemBuilder: (context, index) {
      //     final key = payload.keys.elementAt(index);
      //     final value = payload[key];
      //
      //     return Card(
      //       child: ListTile(
      //         title: Text(key),
      //         subtitle: Text(value.toString()),
      //       ),
      //     );
      //   },
      // ),

      body:Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height:60),
            Image.asset('assets/images/no_notifications.png',height: 340,),
            const SizedBox(height:20),
            Text(
              'No Notification Yet',
            ),
          ],
        ),
      ),
    );
  }
}

