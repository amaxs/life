import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notifications/notification_service.dart';
import 'screens/home_screen.dart';
import 'services/quest_service.dart';
import 'services/user_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => QuestService()),
        Provider(create: (_) => UserService()),
      ],
      child: MaterialApp(
        title: 'LiFE RPG',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
