import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notifications/notification_service.dart';
import 'screens/home_screen.dart';
import 'services/quest_service.dart';
import 'services/user_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final notificationService = NotificationService();
  await notificationService.initialize();

  // Initialize time zones
  tz.initializeTimeZones();

  // Schedule two notifications: one at 9:00 AM and one at 5:00 PM
  DateTime time1 = DateTime.now().copyWith(hour: 9, minute: 00, second: 0);
  DateTime time2 = DateTime.now().copyWith(hour: 18, minute: 00, second: 0);
  // DateTime now = DateTime.now();
  // DateTime time1 = now.add(Duration(minutes: 1));
  // DateTime time2 = now.add(Duration(minutes: 2));
  print('Scheduling time1 notification for $time1');
  print('Scheduling time2 notification for $time2');

  await notificationService.scheduleTwiceDailyNotification(
    1, // First notification ID
    'Morning Reminder',
    'This is your morning reminder!',
    time1,
    2, // Second notification ID
    'Evening Reminder',
    'This is your evening reminder!',
    time2,
  );

   // TODO: no scheduleTwiceDailyNotification notif raising
  // We just schedule a simple notification to trigger in 12 hour
  DateTime scheduledTime = DateTime.now().add(Duration(hours: 12));
  // DateTime scheduledTime = DateTime.now().add(Duration(seconds: 30));
   await notificationService.scheduleNotification(
     1, // Notification ID
     'Quests reminders',
     'Check your quests.',
     scheduledTime,
  );

 runApp(MyApp(notificationService: notificationService));
}

class MyApp extends StatelessWidget {
  final NotificationService notificationService;

  MyApp({required this.notificationService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => QuestService()),
        Provider(create: (_) => UserService()),
        Provider(create: (_) => notificationService), // Provide the notification service
      ],
      child: MaterialApp(
        title: 'LiFE RPG',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: GameTheme.primaryColor,
          tabBarTheme: GameTheme.tabBarTheme,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
