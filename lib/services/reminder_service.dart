import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:vibration/vibration.dart';
import 'package:flutter/material.dart';
import 'package:medhub/models/allriminders/Data.dart';
import 'package:medhub/app/utils.dart';

class ReminderService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Initialize timezone database
    tz.initializeTimeZones();

    // Initialize notification plugin
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      // Add iOS settings if needed
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Handle notification tap if needed
      },
    );
  }

  Future<List<Riminder>?> getallrimiders() async {
    // Implement your API call to get all reminders
    // This is just a placeholder - replace with your actual implementation
    try {
      final response = await apiService.getallrimiders();
      return response;
      return [];
    } catch (e) {
      debugPrint('Error fetching reminders: $e');
      return [];
    }
  }

  Future<bool?> deleteReminder({required num id}) async {
    // Implement your API call to delete a reminder
    // This is just a placeholder - replace with your actual implementation
    try {
      final response = await apiService.deleteReminder(id: id);
     return response;
    } catch (e) {
      debugPrint('Error deleting reminder: $e');
      return false;
    }
  }

  Future<void> scheduleReminder({
    required Riminder reminder,
    required String message,
    required DateTime scheduledTime,
    bool repeat = false,
    String? repeatFrequency,
  }) async {

    try {
      // Schedule notification
      await _scheduleNotification(
        id: reminder.id?.toInt() ?? 0,
        title: 'Reminder',
        body: message,
        scheduledTime: scheduledTime,
        repeat: repeat,
        repeatFrequency: repeatFrequency,
      );

      // Vibrate when reminder triggers
      await _triggerVibration();

      // Save reminder to your backend

    } catch (e) {
      debugPrint('Error scheduling reminder: $e');
      throw Exception('Failed to schedule reminder');
    }
  }

  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    bool repeat = false,
    String? repeatFrequency,
  }) async {
    final Int64List? vibrationPattern = Int64List.fromList([0, 500, 1000, 500]);

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'reminder_channel',
      'Reminders',
      channelDescription: 'Channel for reminder notifications',
      importance: Importance.max,
      priority: Priority.high,
      sound:  RawResourceAndroidNotificationSound('notification_sound'),
      enableVibration: true,
     // vibrationPattern: vibrationPattern,
    );

    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // Add iOS settings if needed
    );

    if (repeat && repeatFrequency != null) {
      // Handle repeating notifications with exact scheduling
      await _notificationsPlugin.periodicallyShow(
        id,
        title,
        body,
        _getRepeatInterval(repeatFrequency),
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exact,
      );
    } else {
      // Schedule single notification with exact timing
      await _notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledTime, tz.local),
        platformChannelSpecifics,
        // androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exact,
      );
    }
  }

  RepeatInterval _getRepeatInterval(String frequency) {
    switch (frequency.toLowerCase()) {
      case 'daily':
        return RepeatInterval.daily;
      case 'weekly':
        return RepeatInterval.weekly;
      default:
        return RepeatInterval.daily;
    }
  }

  Future<void> _triggerVibration() async {
    if (await Vibration.hasVibrator() ?? false) {
      await Vibration.vibrate(
        pattern: [500, 1000, 500, 1000],
        intensities: [128, 255, 128, 255],
      );
    }
  }



  Future<void> cancelReminder(int id) async {
    await _notificationsPlugin.cancel(id);
    // Optionally remove from your backend as well
  }

  Future<void> cancelAllReminders() async {
    await _notificationsPlugin.cancelAll();
    // Optionally remove all from your backend as well
  }
}