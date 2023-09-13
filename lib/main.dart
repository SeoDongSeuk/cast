import 'package:cast/components/cast_themes.dart';
import 'package:cast/pages/home_page.dart';
import 'package:cast/services/cast_notification_service.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final notification = CastNotificationService();
  notification.initializeTimeZone();
  notification.initializeNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // lightTheme 설정
      theme: CastThemes.lightTheme,
      home: const HomePage(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: child!,
      ),
    );
  }
}
