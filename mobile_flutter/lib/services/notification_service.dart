import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await _notifications.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );
  }

  Future<void> scheduleDailyReminder({required int hour, required int minute}) async {
    await _notifications.cancel(1001);

    await _notifications.periodicallyShow(
      1001,
      'Roadmap Reminder',
      'Time to complete today\'s roadmap tasks 🚀',
      RepeatInterval.daily,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_roadmap',
          'Daily Roadmap Reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
