import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          print('Notification payload: $payload');
        }
      },
    );
  }

  Future<void> showNotification(int id, String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'action_reminder_id',
      'action_reminder',
      channelDescription: 'Helper for your quest',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      // icon: 'life_r',
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(id, title, body, platformChannelSpecifics, payload: 'item x');
    print('Notification shown: $title');
  }

  // Schedule a notification at a specific time
  Future<void> scheduleNotification(int id, String title, String body, DateTime scheduledTime) async {
    try {
      tz.initializeTimeZones(); // Ensure that the timezone package is initialized
      print('Scheduling notification for $scheduledTime');

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledTime, tz.local), // Schedules for the local time
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'action_reminder_id',
            'action_reminder',
            channelDescription: 'Helper for your quest',
            importance: Importance.max,
            priority: Priority.high,
            // icon: 'life_r',
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );

      print('Notification scheduled successfully');
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }

  // Schedule a notification to repeat at fixed intervals
  Future<void> scheduleRepeatingNotification(int id, String title, String body, RepeatInterval interval) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'action_reminder_id',
      'action_reminder',
      channelDescription: 'Helper for your quest',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      interval,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
    );

    print('Repeating notification scheduled with interval $interval');
  }

  Future<void> scheduleTwiceDailyNotification(int id1, String title1, String body1, DateTime time1,
      int id2, String title2, String body2, DateTime time2) async {

    print('Scheduling twice daily notifications');

    try {
      // Calculate the first notification time (9:00 AM)
      tz.TZDateTime firstNotificationTime = _nextInstanceOfTime(time1);
      print('First notification time: $firstNotificationTime');

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id1,
        title1,
        body1,
        firstNotificationTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'action_reminder_id',
            'action_reminder',
            channelDescription: 'Helper for your quest',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );

      print('First daily notification scheduled successfully');

      // Calculate the second notification time (5:00 PM)
      tz.TZDateTime secondNotificationTime = _nextInstanceOfTime(time2);
      print('Second notification time: $secondNotificationTime');

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id2,
        title2,
        body2,
        secondNotificationTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'action_reminder_id',
            'action_reminder',
            channelDescription: 'Helper for your quest',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );

      print('Second daily notification scheduled successfully');

    } catch (e) {
      print('Error scheduling notifications: $e');
    }
  }

  tz.TZDateTime _nextInstanceOfTime(DateTime time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, time.hour, time.minute, time.second);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  // Cancel a notification with a specific ID
  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    print('Notification with ID $id canceled');
  }

  // Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    print('All notifications canceled');
  }
}
