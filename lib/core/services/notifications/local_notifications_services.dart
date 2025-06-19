import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsServices {
  static FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> notificationsStreamController = StreamController();


 static Future<void> init()async{
    InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings(
        "@mipmap/ic_launcher",
      ),
      iOS: DarwinInitializationSettings(),
    );
    await notificationsPlugin.initialize(
        settings,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  static addNotificationToStream (NotificationResponse notification){
   notificationsStreamController.add(notification);
  }

  static void onDidReceiveBackgroundNotificationResponse(NotificationResponse notification){
    addNotificationToStream(notification);
  }
  static void onDidReceiveNotificationResponse(NotificationResponse notification){
    addNotificationToStream(notification);
  }

  static Future<void> showBasicNotification({
    required String title,
    required String body,
    int? id,
    String? payload,
    String? channelName,
    String? channelId,
    Importance? importance,
    Priority? priority,
    String? soundName,
  }) async {
    AndroidNotificationDetails android = AndroidNotificationDetails(
        channelId?? 'basic id',
        channelName?? 'basic notification',
        importance: importance?? Importance.max,
        priority: priority?? Priority.high,
        sound: RawResourceAndroidNotificationSound((soundName ?? 'sound.mp3').split('.').first)
    );
    NotificationDetails details = NotificationDetails(
      android: android,
    );
    await notificationsPlugin.show(
      id?? 1,
      title,
      body,
      details,
      payload: payload,
    );
  }

  static Future<void> showRepeatedNotification({
    required String title,
    required String body,
    int? id,
    String? payload,
    String? channelName,
    String? channelId,
    Importance? importance,
    Priority? priority,
    String? soundName,
    RepeatInterval? interval,
  }) async {
     AndroidNotificationDetails android = AndroidNotificationDetails(
      channelId?? 'repeated id',
      channelName?? 'repeated notification',
      importance: importance?? Importance.max,
      priority:priority?? Priority.high,
       sound: RawResourceAndroidNotificationSound((soundName ?? 'sound.mp3').split('.').first)
     );
    NotificationDetails details = NotificationDetails(
      android: android,
    );
    await notificationsPlugin.periodicallyShow(
      id?? 1,
      title,
      body,
      interval ?? RepeatInterval.everyMinute,
      details,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  static Future<void> cancelNotification(int id)async{
   await notificationsPlugin.cancel(id);
  }

  static Future<void> cancelAllNotifications()async{
    await notificationsPlugin.cancelAll();
  }

}