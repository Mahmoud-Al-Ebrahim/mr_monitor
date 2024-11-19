// import 'dart:developer';
// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'local_notification_service.dart';
//
// class NotificationProcess {
//   static NotificationProcess? _instance;
//   static String? myFcmToken;
//
//   NotificationProcess._singleton();
//
//   factory NotificationProcess() =>
//       _instance ??= NotificationProcess._singleton();
//
//   Future fcmToken() async {
//     myFcmToken = await FirebaseMessaging.instance.getToken();
//
//     log(myFcmToken.toString());
//   }
//
//   Future<void> _setForegroundNotificationPresentationOptions() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//             alert: true, badge: true, sound: true);
//   }
//
//   requestPermission() async {
//     if (!Platform.isIOS) {
//       return;
//     }
//
//     await FirebaseMessaging.instance.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//   }
//
//
//   Future<void> init() async {
//     await _setForegroundNotificationPresentationOptions();
//
//     await LocalNotificationService.initialize();
//
//   }
// }
