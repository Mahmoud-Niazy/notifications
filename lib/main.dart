import 'package:flutter/material.dart';
import 'package:notifications/core/services/notifications/local_notifications_services.dart';

import 'features/home/presentation/views/home_view.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationsServices.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeView(),
    );
  }
}