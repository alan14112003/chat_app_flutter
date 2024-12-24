import 'dart:convert';

import 'package:chat_app_flutter/core/dependencies/init_dependencies.dart';
import 'package:chat_app_flutter/features/message/presentation/screens/message_screen.dart';
import 'package:chat_app_flutter/features/video_call/presentation/screen/notify_video_call_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveNotification(
    NotificationResponse notificationResponse,
  ) async {
    final String? payload = notificationResponse.payload;
    if (payload == null) {
      return;
    }

    debugPrint('notification payload: $payload');

    final [routing, data] = payload.split('@:');

    switch (routing) {
      case 'message':
        serviceLocator<GlobalKey<NavigatorState>>().currentState?.push(
              MessageScreen.route(data),
            );
        break;
      case 'video_call':
        Map<String, dynamic> dataDecode = jsonDecode(data);
        serviceLocator<GlobalKey<NavigatorState>>().currentState?.push(
              NotifyVideoCallScreen.route(
                dataDecode['body'],
                dataDecode['roomId'],
              ),
            );
        break;
      default:
    }
  }

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotification,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification,
    );

    _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
      ?..requestNotificationsPermission()
      ..requestExactAlarmsPermission()
      ..requestFullScreenIntentPermission();
  }

  static Future<void> showNotify({
    id = 0,
    required String title,
    required String content,
    required String payload,
  }) async {
    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'com.alan.smart_chat',
        'Smart Chat',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        visibility: NotificationVisibility.public,
      ),
      iOS: DarwinNotificationDetails(),
    );

    // Hiển thị thông báo
    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      content,
      notificationDetails,
      payload: payload,
    );
  }

  static Future<void> hideNotify({id = 0}) async {
    // Tắt thông báo
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}
