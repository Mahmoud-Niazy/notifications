import 'package:flutter/material.dart';
import 'package:notifications/core/services/notifications/local_notifications_services.dart';
import 'package:notifications/features/home/presentation/views/widgets/custom_button.dart';

import '../../../../core/services/background_services/work_manager_services.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
                await WorkManagerServices.init(
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
