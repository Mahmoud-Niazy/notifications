import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;


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
        sound: RawResourceAndroidNotificationSound((soundName ?? 'sound.mp3').split('.').first),
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
       sound: RawResourceAndroidNotificationSound((soundName ?? 'sound.mp3').split('.').first),
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

  static Future<void> showScheduledNotification({
    required String title,
    required String body,
    required DateTime time,
    int? id,
    String? payload,
    String? channelName,
    String? channelId,
    Importance? importance,
    Priority? priority,
    String? soundName,
  }) async {
     AndroidNotificationDetails android = AndroidNotificationDetails(
      channelId ?? 'scheduled id',
      channelName ?? 'scheduled notification',
      importance: importance?? Importance.max,
      priority: priority?? Priority.high,
      sound: RawResourceAndroidNotificationSound((soundName ?? 'sound.mp3').split('.').first),
     );
     NotificationDetails details = NotificationDetails(
      android: android,
    );
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    await notificationsPlugin.zonedSchedule(
      id?? 1,
      title,
      body,
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
      tz.TZDateTime(
        tz.local,
        time.year,
        time.month,
        time.day,
        time.hour,
        time.minute,
        time.second,
      ),
      details,
      payload: payload,
      androidScheduleMode:  AndroidScheduleMode.alarmClock,
    );
  }

  static Future<void> showDailyScheduledNotification({
    required String title,
    required String body,
    required DateTime time,
    int? id,
    String? payload,
    String? channelName,
    String? channelId,
    Importance? importance,
    Priority? priority,
    String? soundName,
  }) async {
     AndroidNotificationDetails android = AndroidNotificationDetails(
      channelId?? 'daily scheduled id',
      channelName?? 'daily scheduled',
      importance:importance ?? Importance.max,
      priority:priority?? Priority.high,
       sound: RawResourceAndroidNotificationSound((soundName ?? 'sound.mp3').split('.').first),
     );
    NotificationDetails details = NotificationDetails(
      android: android,
    );
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    var currentTime = tz.TZDateTime.now(tz.local);
    var scheduleTime = tz.TZDateTime(
      tz.local,
      time.year,
      time.month,
      time.day,
      time.hour,
      time.minute,
      time.second,
    );
    if (scheduleTime.isBefore(currentTime)) {
      scheduleTime = scheduleTime.add(const Duration(days: 1));
    }
    await notificationsPlugin.zonedSchedule(
      id ?? 1,
      title,
      body,
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
      scheduleTime,
      details,
      payload: payload,
      androidScheduleMode:  AndroidScheduleMode.alarmClock,

    );
  }

  static Future<void> cancelNotification(int id)async{
   await notificationsPlugin.cancel(id);
  }

  static Future<void> cancelAllNotifications()async{
    await notificationsPlugin.cancelAll();
  }

}