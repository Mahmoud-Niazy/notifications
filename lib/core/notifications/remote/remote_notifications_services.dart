import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notifications/core/notifications/local/local_notifications_services.dart';
import 'package:notifications/core/notifications/remote/server_key.dart';

class RemoteNotificationsServices {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future init() async {
    await messaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen(handleForegroundMessage);
  }

  static Future<String?> getFcmToken() async {
    String? fcmToken = await messaging.getToken();
    return fcmToken;
  }

  static Future<void> subscribeToTopic(String topic) async {
    await messaging.subscribeToTopic(topic);
  }

  static Future<void> unsubscribeToTopic(String topic) async {
    await messaging.unsubscribeFromTopic(topic);
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    // await Firebase.initializeApp();
    /// IMPLEMENT YOUR ACTION
  }

  static void handleForegroundMessage(RemoteMessage message) {
    LocalNotificationsServices.showBasicNotification(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
    );
  }

  static Future<void> sendNotification({
    required String to,
    required String title,
    required String body,
    String? topic,
    String? image,
}) async {
    String serverKey = await ServerKey.getServerToken();
    await Dio(
      BaseOptions(
        headers: {
          "Authorization": "Bearer $serverKey",
          "Content-Type": "application/json",
        },
      ),
    ).post(
      'https://fcm.googleapis.com/v1/projects/notifications-7ae71/messages:send',
      data: {
        "message": {
          if (topic != null) "topic": topic else "token": to,
          "notification": {
            "title": title,
            "body": body,
            "image": image
          }
        }
      },
    );
  }
}
