import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import '../app/utils.dart';
import '../app/app.locator.dart';
import '../models/addreminder/Data.dart';

class ReminderService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // For vibration pattern
  final Int64List vibrationPattern = Int64List.fromList([0, 500, 200, 500, 200, 500]);

  // Initialize notification settings
  Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,

    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  // iOS notification callback
  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // Handle iOS foreground notification
    print('Received iOS notification: $title, $body');
  }

  // Handle notification tap
  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) {
    // Handle notification tap
    print('Notification tapped: ${notificationResponse.payload}');
    // Navigate to specific screen or perform action based on payload
    // navigationService.navigateTo(...);
  }

  // Schedule a reminder notification
  Future<void> scheduleReminder(Reminder reminder) async {
    // Parse time from string - assuming format is "HH:mm"
    final timeParts = reminder.time!.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    // Parse dates
    final fromDate = DateTime.parse(reminder.fromDate!);
    DateTime? toDate;
    if (reminder.toDate != null && reminder.toDate!.isNotEmpty) {
      toDate = DateTime.parse(reminder.toDate!);
    }

    // Create reminder date with time
    final scheduledDate = DateTime(
      fromDate.year,
      fromDate.month,
      fromDate.day,
      hour,
      minute,
    );

    // Don't schedule if date is in the past
    if (scheduledDate.isBefore(DateTime.now())) {
      print('Reminder date is in the past, not scheduling');
      return;
    }

    // Configure notification details
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'reminder_channel',
      'Reminders',
      channelDescription: 'Channel for reminder notifications',
      importance: Importance.max,
      priority: Priority.high,
      sound: const RawResourceAndroidNotificationSound('notification_sound'),
      enableVibration: true,
      vibrationPattern: vibrationPattern,
    );

    final iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
      presentSound: true,
      presentBadge: true,
      presentAlert: true,
    );

    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    // Schedule the notification
    await flutterLocalNotificationsPlugin.zonedSchedule(
      reminder.id!.toInt(),
      'Reminder',
      reminder.message,
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: reminder.repeat!
          ? DateTimeComponents.time
          : null,
    );

    print('Scheduled reminder: ${reminder.message} at $scheduledDate');
  }

  // Cancel a specific reminder notification
  Future<void> cancelReminder(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  // Cancel all reminder notifications
  Future<void> cancelAllReminders() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  // Convert API Reminder to local Reminder model if needed
  Reminder convertFromApiModel(Reminder apiReminder) {
    // Parse time from string - assuming format is "HH:mm"
    final timeParts = apiReminder.time!.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    return Reminder(
      id: apiReminder.id,
      message: apiReminder.message ?? '',
      repeat: apiReminder.repeat ?? false,
      time: DateTime(1, 1, 1, hour, minute).toString(),
      fromDate: DateTime.parse(apiReminder.fromDate!).toString(),
      toDate: apiReminder.toDate != null && apiReminder.toDate!.isNotEmpty
          ? DateTime.parse(apiReminder.toDate!).toString()
          : null,
      // Default or map from API if available
    );
  }
}