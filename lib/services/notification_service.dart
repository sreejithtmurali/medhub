import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_init;
import '../models/reminder.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz_init.initializeTimeZones();

    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap
      },
    );
  }

  NotificationDetails _getNotificationDetails(ReminderPriority priority) {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'reminder_channel',
      'Reminders',
      channelDescription: 'Reminder notifications',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
      playSound: true,
      sound: const RawResourceAndroidNotificationSound('notification_sound'),
    );

    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'notification_sound.aiff',
    );

    return NotificationDetails(android: androidDetails, iOS: iosDetails);
  }

  Future<void> scheduleReminder(Reminder reminder) async {
    final notificationDetails = _getNotificationDetails(reminder.priority);

    if (reminder.isPeriodic && reminder.toDate != null) {
      // For periodic notifications, we would set up recurring notifications
      // This is a simple implementation - in production, you'd handle more complex cases
      await _notificationsPlugin.zonedSchedule(
        reminder.id.hashCode,
        'Reminder',
        reminder.message,
        _getNextInstanceTime(reminder),
        notificationDetails,

        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time, androidScheduleMode: AndroidScheduleMode.exact,
      );
    } else {
      // One-time notification
      await _notificationsPlugin.zonedSchedule(
        reminder.id.hashCode,
        'Reminder',
        reminder.message,
        tz.TZDateTime.from(
          DateTime(
            reminder.fromDate.year,
            reminder.fromDate.month,
            reminder.fromDate.day,
            reminder.time.hour,
            reminder.time.minute,
          ),
          tz.local,
        ),
        notificationDetails,

        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, androidScheduleMode: AndroidScheduleMode.exact,
      );
    }
  }

  tz.TZDateTime _getNextInstanceTime(Reminder reminder) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(
      tz.local,
      reminder.fromDate.year,
      reminder.fromDate.month,
      reminder.fromDate.day,
      reminder.time.hour,
      reminder.time.minute,
    );

    if (scheduledDate.isBefore(now)) {
      // If the scheduled time is in the past, set it for the next day
      return scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> cancelReminder(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  Future<void> cancelAllReminders() async {
    await _notificationsPlugin.cancelAll();
  }
}