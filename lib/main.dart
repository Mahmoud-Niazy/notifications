import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notifications/core/notifications/local/local_notifications_services.dart';
import 'core/notifications/remote/remote_notifications_services.dart';
import 'features/home/presentation/views/home_view.dart';
import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Future.wait([
    LocalNotificationsServices.init(),
    RemoteNotificationsServices.init(),
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}