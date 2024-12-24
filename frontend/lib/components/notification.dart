import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('assets/img/logo.png');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  RemoteNotification? notification = message.notification;
  if (notification != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id', // TODO: replace with your channel ID
          'channel_name', // TODO: replace with your channel name
          importance: Importance.max,
          priority: Priority.high,
          onlyAlertOnce: true, // TODO: not sure if this do what i want.
        ),
      ),
    );
  }
}
