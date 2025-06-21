import 'package:workmanager/workmanager.dart';
import '../notifications/local/local_notifications_services.dart';

class WorkManagerServices {
  static Future<void> registerMyPeriodicNotificationTask({
    required String title,
    required String body,
    required DateTime time,
}) async {
    await Workmanager().registerPeriodicTask(
      'id',
      'show simple notification',
      frequency: const Duration(minutes: 15),
      existingWorkPolicy: ExistingWorkPolicy.replace,
      inputData: {
        "title" : title,
        "body" : body,
        "year" : time.year.toString(),
        "month" : time.month.toString(),
        "day" : time.day.toString(),
        "hour" : time.hour.toString(),
        "minute" : time.minute.toString(),
        "second" : time.second.toString(),
     },
    );
  }

  static Future<void> init({
    required String title,
    required String body,
    required DateTime time,
  })  async{
     await Workmanager().initialize(handleDailyNotification, isInDebugMode: true);
    await registerMyPeriodicNotificationTask(
      title: title,
      body: body,
      time: time,
    );

  }

  static Future<void> cancelTask(String id) async{
    await Workmanager().cancelAll();
  }

  @pragma('vm:entry-point')
  static void handleDailyNotification(){
    Workmanager().executeTask((taskName, inputData) async{
      await LocalNotificationsServices.showDailyScheduledNotification(
        title: inputData?['title'] ?? '',
        body:  inputData?['body'] ?? '',
        time: (inputData!=null &&
        inputData['time'] != null) ?
            DateTime(
              int.parse(inputData['year'].toString()),
              int.parse(inputData['month'].toString()),
              int.parse(inputData['day'].toString()),
              int.parse(inputData['hour'].toString()),
              int.parse(inputData['minute'].toString()),
              int.parse(inputData['second'].toString()),
            )
            : DateTime.now().add(Duration(seconds: 10)),
      );
      return Future.value(true);
    });
  }
}


