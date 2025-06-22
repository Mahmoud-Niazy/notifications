import 'package:flutter/material.dart';
import 'package:notifications/core/notifications/local/local_notifications_services.dart';
import 'package:notifications/core/notifications/remote/remote_notifications_services.dart';
import 'package:notifications/features/home/presentation/views/widgets/custom_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void listenToNotificationStreamController(){
    LocalNotificationsServices.notificationsStreamController.stream.listen((notification){
      ///
    });
  }
  @override
  void initState() {
    listenToNotificationStreamController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              onPressed: () async{
               await LocalNotificationsServices.showBasicNotification(
                  title: 'TEST BASIC',
                  body: 'Mahmoud sent a message',
                );
              },
              title: 'Basic',
            ),
            CustomButton(
              onPressed: () async{
                await LocalNotificationsServices.showRepeatedNotification(
                  title: 'TEST REPEATED',
                  body: 'Mahmoud sent a message',
                );
              },
              title: 'Periodic',
            ),
            CustomButton(
              onPressed: () async{
                await LocalNotificationsServices.showScheduledNotification(
                  title: 'TEST SCHEDULED',
                  body: 'Mahmoud sent a message',
                  time: DateTime.now().add(Duration(seconds: 5)),
                );
              },
              title: 'Scheduled',
            ),
            CustomButton(
              onPressed: () async{
               await LocalNotificationsServices.showDailyScheduledNotification(
                  title: 'TEST DAILY SCHEDULED',
                  body: 'Mahmoud sent a message',
                  time: DateTime(
                    2025,
                    6,
                    21,
                    2,
                    51,
                  ),
                );
              },
              title: 'Daily Scheduled',
            ),

            CustomButton(
              onPressed: () async{
                await RemoteNotificationsServices.sendNotification(
                  to: '',
                  title: 'TEST REMOTE',
                  body: 'mahmoud sent a message',
                  image: 'https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/1015f/MainBefore.jpg',
                );
              },
              title: 'Remote',
            ),
            CustomButton(
              color: Colors.red,
              onPressed: () async{
                await LocalNotificationsServices.cancelAllNotifications();
              },
            title: 'Cancel All Notifications',
            ),
          ],
        ),
      ),
    );
  }
}
