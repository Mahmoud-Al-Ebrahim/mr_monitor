import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_monitor3/business_logic/appointment_bloc/appointment_bloc.dart';
import '../../main.dart';

class AwesomeNotification {
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    var data = jsonDecode(receivedAction.buttonKeyPressed.split(' ')[1]);
    if (receivedAction.buttonKeyPressed.startsWith('DONE')) {
      print(data);
      BlocProvider.of<AppointmentBloc>(MyApp.navigatorKey.currentContext!)
          .add(TakeMedicineEvent(medicineId: data['id']));
    } else {
        await AwesomeNotification.createNewNotification(
            data['name'], data['id'], int.parse(data['hour']),
            int.parse(data['minute']) + 2);
      }
    }

  static init() async {
    await AwesomeNotifications().initialize(
        null, //'resource://drawable/res_app_icon',//
        [
          NotificationChannel(
              channelKey: 'alerts',
              channelName: 'Alerts',
              channelDescription: 'Notification tests as alerts',
              playSound: true,
              onlyAlertOnce: false,
              enableVibration: true,
              enableLights: true,
              criticalAlerts: true,
              importance: NotificationImportance.Max,
              defaultPrivacy: NotificationPrivacy.Private,
              defaultColor: Colors.deepPurple,
              ledColor: Colors.deepPurple)
        ],
        debug: true);
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onDismissActionReceivedMethod: onActionReceivedMethod,
    );
  }

  static Future<bool> displayNotificationRationale() async {
    bool userAuthorized = false;
    BuildContext context = MyApp.navigatorKey.currentContext!;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Get Notified!',
                style: Theme.of(context).textTheme.titleLarge),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/animated-bell.gif',
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                    'Allow Awesome Notifications to send you beautiful notifications!'),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Deny',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () async {
                    userAuthorized = true;
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Allow',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.deepPurple),
                  )),
            ],
          );
        });
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  static Future<void> createNewNotification(
      String medicineName, String medicineId, int hour, int minutes) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;
    String localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
    String data = jsonEncode({
      'id': medicineId,
      'name': medicineName,
      'hour': hour.toString(),
      'minute': minutes.toString(),
    });
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: -1,
          channelKey: 'alerts',
          title: medicineName,
          body:
              'Its Time for the $medicineName pill, if you are busy right now use the skip button to remind you after 2 minutes',
          notificationLayout: NotificationLayout.BigPicture,
          fullScreenIntent: true,
          bigPicture: "asset://assets/images/capsule2.png",
          largeIcon: "asset://assets/images/capsule2.png",
        ),
        actionButtons: [
          NotificationActionButton(
              key: 'SKIP $data',
              label: 'Skip',
              color: Colors.red,
              actionType: ActionType.DismissAction),
          NotificationActionButton(
            key: 'DONE $data',
            label: 'Done',
            color: Colors.red,
            actionType: ActionType.DismissAction,
          )
        ],
        schedule: NotificationCalendar(
            hour: hour,
            minute: minutes,
            timeZone: localTimeZone,
            allowWhileIdle: true,
            repeats: false));

    // bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    // if (!isAllowed) isAllowed = await displayNotificationRationale();
    // if (!isAllowed) return;
    //
    // await AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //         id: -1, // -1 is replaced by a random number
    //         channelKey: 'alerts',
    //         title: 'Huston! The eagle has landed!',
    //         wakeUpScreen: true,
    //         body:
    //         "A small step for a man, but a giant leap to Flutter's community!",
    //         bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
    //         largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
    //         //'asset://assets/images/balloons-in-sky.jpg',
    //         notificationLayout: NotificationLayout.BigPicture,
    //         payload: {'notificationId': '1234567890'}),
    //     actionButtons: [
    //       NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
    //       NotificationActionButton(
    //           key: 'REPLY',
    //           label: 'Reply Message',
    //           requireInputText: true,
    //           actionType: ActionType.SilentAction),
    //       NotificationActionButton(
    //           key: 'DISMISS',
    //           label: 'Dismiss',
    //           actionType: ActionType.DismissAction,
    //           isDangerousOption: true)
    //     ]
    //     );
  }
}
