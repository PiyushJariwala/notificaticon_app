import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('app_icon');
    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    tz.initializeTimeZones();

    notificationsPlugin.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showNotification();
              },
              child: const Text("Notification"),
            ),
            ElevatedButton(
              onPressed: () {
                showSchedualNotification();
              },
              child: const Text("new"),
            ),
          ],
        ),
      ),
    );
  }

  void showNotification() {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("1", "Schedual",
            priority: Priority.high, importance: Importance.max);

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    notificationsPlugin.show(
        1,
        "notification",
        "Flutter notification testing",
        NotificationDetails(
            android: androidNotificationDetails, iOS: iosNotificationDetails));
  }

  void showSchedualNotification() {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("1", "Schedual",
            priority: Priority.high, importance: Importance.max);
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    notificationsPlugin.zonedSchedule(
        1,
        "flutter testing",
        "massage fo flutter devloper ",
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 3)),
        NotificationDetails(
            android: androidNotificationDetails, iOS: iosNotificationDetails),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
}
