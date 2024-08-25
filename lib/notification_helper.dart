// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:googleapis_auth/auth_io.dart' as auth;   //googleapis_auth: ^1.6.0
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'core/shared_constabts.dart';
//
// class NotificationsHelper {
//   // creat instance of fbm
//   final _firebaseMessaging = FirebaseMessaging.instance;
//
//   // initialize notifications for this app or device
//   Future<void> initNotifications() async {
//     await _firebaseMessaging.requestPermission();
//     // get device token
//     String? deviceToken = await _firebaseMessaging.getToken();
//     //DeviceToken = deviceToken;
//
//     print(
//         "===================Device FirebaseMessaging Token====================");
//     print(deviceToken);
//     print(
//         "===================Device FirebaseMessaging Token====================");
//   }
//
//   // handle notifications when received
//   void handleMessages(RemoteMessage? message) {
//     if (message != null) {
//       // navigatorKey.currentState?.pushNamed(NotificationsScreen.routeName, arguments: message);
//       // showToast(
//       //     text: 'on Background Message notification',
//       //     state: ToastStates.SUCCESS);
//       Constants.showToast(msg: 'on Background Message notification',
//           gravity: ToastGravity.BOTTOM,
//           color: Colors.green);
//     }
//   }
//
//   // handel notifications in case app is terminated
//   void handleBackgroundNotifications() async {
//     FirebaseMessaging.instance.getInitialMessage().then((handleMessages));
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
//   }
//
//   Future<String?> getAccessToken() async {
//     final serviceAccountJson = {
//       "type": "service_account",
//       "project_id": "quakkomesh",
//       "private_key_id": "f5bc7099876e3610a83e97c3d6635f7e04c3d89b",
//       "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDsP1pVx5ODm7re\ntszs8TnyROeKdiBEADXIRl+6VjnlZtcH51xD49o6dgzZ/FYttnONBI52Hhm2aY6f\n2VN2ahZDRSZveX5S4Nii83ef+7jfLTdqIosePd036PcdVkM7oV9Nos7xkIoT5Md7\n6wsA4xd9FS1NcKfs5Sz9PnbSz5FeYEqrsZBYRsiE301YtXqVt26VZLOF+zn+3xV2\nVMjigOC7XJiS6pG1+wsNYxKt4dq9Je3/YLQXQLqnGOGqpeN1o46x9Kref8j+tAQM\nlixpHC8X+ssGGdop/zKhHcHIqZlmhpR+LAS7FzqnFfNu9tcDSQ/0xs4cPROw84a9\n0HdzVnL5AgMBAAECggEAEfZL0St665iQD+CN2n1eyVee081hF6UnxwHpblqhoppR\nQsBpqJ8Zgl9jtmvem4bR6J4OPNcotPtNRO8PpE2y7UtufYRFwVm8xEBG+fV4HBPX\n25cjxQQGyU+fq5iERR44XPKXfGYKcYfFTlvTutiz+lEoCsluzcQA9II8I5F059wR\n9ORZyKC1YM6g8BsMUA3LNzg/+YtIoEZA41knD0/5jo/rcDSmcTtjnU+y1OWyeFnF\nxRwbrUk2hxduVPfpsdP73lHnz/4ihS5h4QL7CB2238h8QzHtw5CxZ9q4tkr2XjYK\n6DkZvlLOdYX31sK5hrNnRJsIZWNcgBO5ERjWRllz+QKBgQD/e7S9ua/iE5nyP2zm\nGbzW2ur5w6wCImi+ooRrrvWzcWrc2n8ZsqjZRCdVr1x+aXEFHVK0kysUI1+GLu6J\nryTvH0q2voFuIwQfWJbTDoBp31VI7Afib41/I16z5j22xvnTfwe6yrrLxObxOmDf\nW3Nyts2R1y1sfc7ubXz2OR1fLQKBgQDsua+sC6USORCWmQO20vzmOxkaMczQ8VX4\n5cbFHKUnhjOQREME+FxiKey9XbYbRgCdfFO+dASaYfRrH71pzQ2VzemX9gEwQmtP\ntV272snbA3h5dhnmHXUM+CTeyefqrjAotBA2AA3SQRReVCLemtkvvcy57GF+LcwB\nkUvsv6cifQKBgQDtkA5EzUFrK2bfB3Mvk4cxEmekz/pGEdDsUxpnN01pCnGf49yD\n/MldHi6lUmbjdRCO/PFG0AIiu7G7iDBu/tmNML+8pfCchRr0OuAkaTunNvCK2k+K\nksg0DKOnDNUd/G+Z5mk9m/2ONQ26CdrCVrtHVAxbLIckdufQdSbZncpeEQKBgQCJ\nl3Pv/+S2Lszhe5aZERFFkFwKyZ9OYrehr4xUzU2BJ5OY6tQ5c1HfDJc5idprB8kb\nwEO8kxqJ0R2Llis176VRyRlY5ffS4QgWkEgnBAgHcID5uBddlQmPvDtR8vEFirEb\nN22ktWtTJdh861JJKJ/MC/mOp0ITYPMOhjEnLk4q0QKBgQCJRR7FHWNNPoDTaQHo\nDc1J4ZeMBD95JIVVfHN9chLSkjqga4sCLpHyeYqlNspPHSzifQKIPNhmvYUllrVw\n3/EI1uFfxEswy7D4UO8KNLMrZ5V7YHkfX+mEllUBR0V9EaiuqB4ppMQgEFFVx7z6\nys9KGAnGtcgyQtlqhsIRriZeAg==\n-----END PRIVATE KEY-----\n",
//       "client_email": "firebase-adminsdk-pknva@quakkomesh.iam.gserviceaccount.com",
//       "client_id": "109575697755707095698",
//       "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//       "token_uri": "https://oauth2.googleapis.com/token",
//       "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//       "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-pknva%40quakkomesh.iam.gserviceaccount.com",
//       "universe_domain": "googleapis.com"
//     };
//
//     List<String> scopes = [
//       "https://www.googleapis.com/auth/userinfo.email",
//       "https://www.googleapis.com/auth/firebase.database",
//       "https://www.googleapis.com/auth/firebase.messaging"
//     ];
//
//     try {
//       http.Client client = await auth.clientViaServiceAccount(
//           auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);
//
//       auth.AccessCredentials credentials =
//           await auth.obtainAccessCredentialsViaServiceAccount(
//               auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
//               scopes,
//               client);
//
//       client.close();
//       print(
//           "Access Token: ${credentials.accessToken.data}"); // Print Access Token
//       return credentials.accessToken.data;
//     } catch (e) {
//       print("Error getting access token: $e");
//       return null;
//     }
//   }
//
//   Map<String, dynamic> getBody({
//     required String fcmToken,
//     required String title,
//     required String body,
//     required String userId,
//     String? type,
//   }) {
//     return {
//       "message": {
//         "token": fcmToken,
//         "notification": {"title": title, "body": body},
//         "android": {
//           "notification": {
//             "notification_priority": "PRIORITY_MAX",
//             "sound": "default"
//           }
//         },
//         "apns": {
//           "payload": {
//             "aps": {"content_available": true}
//           }
//         },
//         "data": {
//           "type": type,
//           "id": userId,
//           "click_action": "FLUTTER_NOTIFICATION_CLICK"
//         }
//       }
//     };
//   }
//
//   Future<void> sendNotifications({
//     required String fcmToken,
//     required String title,
//     required String body,
//     required String userId,
//     String? type,
//   }) async {
//     try {
//       var serverKeyAuthorization = await getAccessToken();
//
//       // change your project id
//       const String urlEndPoint =
//           "https://fcm.googleapis.com/v1/projects/quakkomesh/messages:send";
//
//       Dio dio = Dio();
//       dio.options.headers['Content-Type'] = 'application/json';
//       dio.options.headers['Authorization'] = 'Bearer $serverKeyAuthorization';
//
//       var response = await dio.post(
//         urlEndPoint,
//         data: getBody(
//           userId: userId,
//           fcmToken: fcmToken,
//           title: title,
//           body: body,
//           type: type ?? "message",
//         ),
//       );
//
//       // Print response status code and body for debugging
//       print('Response Status Code: ${response.statusCode}');
//       print('Response Data: ${response.data}');
//     } catch (e) {
//       print("Error sending notification: $e");
//     }
//   }
// }
