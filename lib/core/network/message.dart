import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_quakka/core/theming/text_styles.dart';
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
          baseColor: Colors.white,
          highlightColor: Colors.white,
          child: Text(
            HomeCubit.get(context).isArabic ? "الاشعارات" : 'Notification',
          ),
        ),
      ),

      body: Stack(

        children: [
          Image.asset(
            'assets/images/background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,

          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFFFFEBB4).withOpacity(0.8),
          ),
          // Check if there are notifications
          payload.isEmpty
              ? Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   SizedBox(height: 60.h),
                  Image.asset('assets/images/no_notifications.png', height: 340),
                   SizedBox(height: 20.h),
                   Text('No Notification Yet'),
                ],
              ),
            ),
          )
              : ListView.builder(
            itemCount: payload.length,
            itemBuilder: (context, index) {
              final key = payload.keys.elementAt(index);
              final value = payload[key];

              return Card(

                color: ColorResources.apphighlightColor,

                child: ListTile(
                  title: Text(
                    key,
                    style: AppTextStyles.categoryTextStyle,
                  ),
                  subtitle: Text(
                    value.toString(),
                    style: AppTextStyles.categoryTextStyle,
                  ),
                ),
              );
            },
          ),
        ],
      ),

      // body:  Stack(
      //   children: [
      //     Image.asset(
      //       'assets/images/background.png',
      //       width: double.infinity,
      //       height: double.infinity,
      //       fit: BoxFit.cover,
      //
      //     ),
      //     Container(
      //       width: double.infinity,
      //       height: double.infinity,
      //       color: const Color(0xFFFFFEBB4).withOpacity(0.8),
      //     ),
      //     Center(
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         const SizedBox(height:60),
      //         Image.asset('assets/images/no_notifications.png',height: 340,),
      //         const SizedBox(height:20),
      //         const Text(
      //           'No Notification Yet',
      //         ),
      //       ],
      //     ),
      //   )],
      // ),
    );
  }
}

