import 'package:alarm/alarm.dart';
import 'package:alarm/model/volume_settings.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import '../app/utils.dart';
import '../models/addreminder/Data.dart'; // Ensure this matches your Reminder model

class ReminderService {
  final Int64List vibrationPattern = Int64List.fromList([0, 500, 200, 500, 200, 500]);
  late tz.Location _location; // Deferred initialization

  // Singleton pattern
  static final ReminderService _instance = ReminderService._();
  factory ReminderService() => _instance;
  ReminderService._();

  static Future<void> initialize() async {
    tz.initializeTimeZones();
    _instance._location = tz.getLocation('Asia/Kolkata');
    try {
      await Alarm.init();
      Alarm.ringStream.stream.listen(_instance.onDidReceiveAlarm);
      debugPrint("✅ Alarm service initialized successfully");
    } catch (e) {
      debugPrint("❌ Failed to initialize alarm service: $e");
      rethrow;
    }
  }

  Future<void> scheduleReminder(Reminder reminder) async {
    try {
      debugPrint("⏰ Scheduling reminder: ${reminder.message}");
      debugPrint("⏰ Time: ${reminder.time}");
      debugPrint("⏰ From Date: ${reminder.fromDate}");
      debugPrint("⏰ Repeat: ${reminder.repeat}");
      debugPrint("⏰ To Date: ${reminder.toDate}");

      final timeParts = reminder.time!.split(':');
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      final fromDate = DateTime.parse(reminder.fromDate!);
      final toDate = reminder.toDate != null ? DateTime.parse(reminder.toDate!) : null;

      DateTime scheduledDate = tz.TZDateTime(
        _location,
        fromDate.year,
        fromDate.month,
        fromDate.day,
        hour,
        minute,
      );

      if (scheduledDate.isBefore(DateTime.now())) {
        if (reminder.repeat!) {
          scheduledDate = scheduledDate.add(const Duration(days: 1));
          if (scheduledDate.isBefore(DateTime.now())) {
            debugPrint("❌ Error: Next scheduled time is still in the past!");
            return;
          }
        } else {
          debugPrint("❌ Error: Scheduled time is in the past!");
          return;
        }
      }

      final alarmSettings = AlarmSettings(
        id: reminder.id!.toInt(),
        dateTime: scheduledDate,
        assetAudioPath: 'assets/sounds/notification_sound.mp3',
        volumeSettings: VolumeSettings.fade(
          volume: 0.8,
          fadeDuration: const Duration(seconds: 3),
        ),
        notificationSettings: NotificationSettings(
          title: 'Reminder',
          body: reminder.message ?? '',
          stopButton: 'Stop',
        ),
        loopAudio: true,
        vibrate: true,
        warningNotificationOnKill: true,
        androidFullScreenIntent: true,
        allowAlarmOverlap: false,
        iOSBackgroundAudio: true,
        payload: reminder.id.toString(),
      );

      await Alarm.set(alarmSettings: alarmSettings);

      if (reminder.repeat! && toDate != null) {
        DateTime currentDate = scheduledDate;
        int instanceId = reminder.id!.toInt() + 1;

        while (currentDate.isBefore(toDate) && instanceId < reminder.id!.toInt() + 100) {
          currentDate = currentDate.add(const Duration(days: 1));
          if (currentDate.isAfter(DateTime.now())) {
            final recurringAlarmSettings = AlarmSettings(
              id: instanceId,
              dateTime: currentDate,
              assetAudioPath: 'assets/sounds/notification_sound.mp3',
              volumeSettings: VolumeSettings.fade(
                volume: 0.8,
                fadeDuration: const Duration(seconds: 3),
              ),
              notificationSettings: NotificationSettings(
                title: "Hello Sir,",
                body: '${reminder.message}',
                stopButton: 'Stop',
              ),
              loopAudio: true,
              vibrate: true,
              warningNotificationOnKill: true,
              androidFullScreenIntent: true,
              allowAlarmOverlap: false,
              iOSBackgroundAudio: true,
              payload: reminder.id.toString(),
            );
            await Alarm.set(alarmSettings: recurringAlarmSettings);
            instanceId++;
          }
        }
        debugPrint("✅ Scheduled ${instanceId - reminder.id!.toInt()} recurring instances");
      }

      debugPrint("✅ Reminder scheduled successfully!");
    } catch (e) {
      debugPrint("❌ Failed to schedule: $e");
      rethrow;
    }
  }

  void onDidReceiveAlarm(AlarmSettings alarmSettings) {
    debugPrint('Alarm triggered: ${alarmSettings.id}');
    debugPrint('Payload: ${alarmSettings.payload}');
  }

  Future<void> cancelReminder(int id) async {
    try {
      await Alarm.stop(id);
      debugPrint("✅ Cancelled reminder with ID: $id");
    } catch (e) {
      debugPrint("❌ Failed to cancel reminder $id: $e");
    }
  }

  Future<void> cancelAllReminders() async {
    try {
      await Alarm.stopAll();
      debugPrint("✅ Cancelled all reminders");
    } catch (e) {
      debugPrint("❌ Failed to cancel all reminders: $e");
    }
  }

  Future<void> testAlarm() async {
    try {
      final now = DateTime.now().add(const Duration(seconds: 5));
      final alarmSettings = AlarmSettings(
        id: 1,
        dateTime: now,
        assetAudioPath: 'assets/sounds/notification_sound.mp3',
        volumeSettings: VolumeSettings.fade(
          volume: 0.8,
          fadeDuration: const Duration(seconds: 3),
        ),
        notificationSettings: const NotificationSettings(
          title: 'Test Alarm',
          body: 'If you see this, alarms work!',
          stopButton: 'Stop',
        ),
        loopAudio: true,
        vibrate: true,
        warningNotificationOnKill: true,
        androidFullScreenIntent: true,
        allowAlarmOverlap: false,
        iOSBackgroundAudio: true,
        payload: 'test',
      );
      await Alarm.set(alarmSettings: alarmSettings);
      debugPrint("✅ Test alarm scheduled for 5 seconds from now");
    } catch (e) {
      debugPrint("❌ Failed to schedule test alarm: $e");
    }
  }
}
// import 'package:alarm/alarm.dart';
// import 'package:alarm/model/volume_settings.dart';
// import 'package:flutter/material.dart';
// import 'dart:typed_data';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;
//
// import '../app/utils.dart';
// import '../app/app.locator.dart';
// import '../models/addreminder/Data.dart';
//
// class ReminderService {
//   final Int64List vibrationPattern = Int64List.fromList([0, 500, 200, 500, 200, 500]);
//   tz.Location _location = tz.local;
//
//   static Future<void> initializeTimeZones() async {
//     tz.initializeTimeZones();
//   }
//
//   Future<void> init() async {
//     _location = tz.getLocation('Asia/Kolkata');
//
//     try {
//       await Alarm.init();
//       Alarm.ringStream.stream.listen((alarmSettings) {
//         onDidReceiveAlarm(alarmSettings);
//       });
//       debugPrint("✅ Alarm service initialized successfully");
//     } catch (e) {
//       debugPrint("❌ Failed to initialize alarm service: $e");
//       rethrow;
//     }
//   }
//
//   Future<void> scheduleReminder(Reminder reminder) async {
//     try {
//       debugPrint("⏰ Scheduling reminder: ${reminder.message}");
//       debugPrint("⏰ Time: ${reminder.time}");
//       debugPrint("⏰ From Date: ${reminder.fromDate}");
//       debugPrint("⏰ Repeat: ${reminder.repeat}");
//       debugPrint("⏰ To Date: ${reminder.toDate}");
//
//       final timeParts = reminder.time!.split(':');
//       final hour = int.parse(timeParts[0]);
//       final minute = int.parse(timeParts[1]);
//       final fromDate = DateTime.parse(reminder.fromDate!);
//       final toDate = reminder.toDate != null ? DateTime.parse(reminder.toDate!) : null;
//
//       DateTime scheduledDate = tz.TZDateTime(
//         _location,
//         fromDate.year,
//         fromDate.month,
//         fromDate.day,
//         hour,
//         minute,
//       );
//
//       if (scheduledDate.isBefore(DateTime.now())) {
//         if (reminder.repeat!) {
//           scheduledDate = scheduledDate.add(const Duration(days: 1));
//           if (scheduledDate.isBefore(DateTime.now())) {
//             debugPrint("❌ Error: Next scheduled time is still in the past!");
//             return;
//           }
//         } else {
//           debugPrint("❌ Error: Scheduled time is in the past!");
//           return;
//         }
//       }
//
//       final alarmSettings = AlarmSettings(
//         id: reminder.id!.toInt(),
//         dateTime: scheduledDate,
//         assetAudioPath: 'assets/sounds/notification_sound.mp3',
//         volumeSettings: VolumeSettings.fade(
//           volume: 0.8,
//           fadeDuration: Duration(seconds: 3),
//         ),
//         notificationSettings: NotificationSettings(
//           title: 'Reminder',
//           body: reminder.message ?? '',
//           stopButton: 'Stop',
//
//         ),
//         loopAudio: true,
//         vibrate: true,
//         warningNotificationOnKill: true,
//         androidFullScreenIntent: true,
//         allowAlarmOverlap: false,
//         iOSBackgroundAudio: true,
//         payload: reminder.id.toString(),
//       );
//
//       await Alarm.set(alarmSettings: alarmSettings);
//
//       if (reminder.repeat! && toDate != null) {
//         DateTime currentDate = scheduledDate;
//         int instanceId = reminder.id!.toInt() + 1;
//
//         while (currentDate.isBefore(toDate) && instanceId < reminder.id!.toInt() + 100) {
//           currentDate = currentDate.add(const Duration(days: 1));
//           if (currentDate.isAfter(DateTime.now())) {
//
//
//             final alarmSettings = AlarmSettings(
//               id: instanceId,
//               dateTime: currentDate,
//               assetAudioPath: 'assets/sounds/notification_sound.mp3',
//               volumeSettings: VolumeSettings.fade(
//                 volume: 0.8,
//                 fadeDuration: Duration(seconds: 3),
//               ),
//               notificationSettings: NotificationSettings(
//                 title: "Hellow Sir,",
//                 body: '${reminder.message}',
//                 stopButton: 'Stop',
//               ),
//               loopAudio: true,
//               vibrate: true,
//               warningNotificationOnKill: true,
//               androidFullScreenIntent: true,
//               allowAlarmOverlap: false,
//               iOSBackgroundAudio: true,
//               payload: reminder.id.toString(),
//             );
//             await Alarm.set(alarmSettings: alarmSettings);
//             instanceId++;
//           }
//         }
//         debugPrint("✅ Scheduled ${instanceId - reminder.id!.toInt()} recurring instances");
//       }
//
//       debugPrint("✅ Reminder scheduled successfully!");
//     } catch (e) {
//       debugPrint("❌ Failed to schedule: $e");
//       rethrow;
//     }
//   }
//
//   void onDidReceiveAlarm(AlarmSettings alarmSettings) {
//     debugPrint('Alarm triggered: ${alarmSettings.id}');
//     debugPrint('Payload: ${alarmSettings.payload}');
//     // Handle alarm trigger here using the payload if needed
//   }
//
//   Future<void> cancelReminder(int id) async {
//     try {
//       await Alarm.stop(id);
//       debugPrint("✅ Cancelled reminder with ID: $id");
//     } catch (e) {
//       debugPrint("❌ Failed to cancel reminder $id: $e");
//     }
//   }
//
//   Future<void> cancelAllReminders() async {
//     try {
//       await Alarm.stopAll();
//       debugPrint("✅ Cancelled all reminders");
//     } catch (e) {
//       debugPrint("❌ Failed to cancel all reminders: $e");
//     }
//   }
//
//   Reminder convertFromApiModel(Reminder apiReminder) {
//     final timeParts = apiReminder.time!.split(':');
//     final hour = int.parse(timeParts[0]);
//     final minute = int.parse(timeParts[1]);
//
//     return Reminder(
//       id: apiReminder.id,
//       message: apiReminder.message ?? '',
//       repeat: apiReminder.repeat ?? false,
//       time: DateTime(1, 1, 1, hour, minute).toString(),
//       fromDate: DateTime.parse(apiReminder.fromDate!).toString(),
//       toDate: apiReminder.toDate != null && apiReminder.toDate!.isNotEmpty
//           ? DateTime.parse(apiReminder.toDate!).toString()
//           : null,
//     );
//   }
//
//   Future<void> testAlarm() async {
//     try {
//       final now = DateTime.now().add(const Duration(seconds: 5));
//       final alarmSettings = AlarmSettings(
//         id: 1,
//         dateTime: now,
//         assetAudioPath: 'assets/sounds/notification_sound.mp3',
//         volumeSettings: VolumeSettings.fade(
//           volume: 0.8,
//           fadeDuration: Duration(seconds: 3),
//         ),
//         notificationSettings: NotificationSettings(
//           title: 'Test Alarm',
//           body: 'If you see this, alarms work!',
//           stopButton: 'Stop',
//         ),
//         loopAudio: true,
//         vibrate: true,
//         warningNotificationOnKill: true,
//         androidFullScreenIntent: true,
//         allowAlarmOverlap: false,
//         iOSBackgroundAudio: true,
//         payload: 'test',
//       );
//       await Alarm.set(alarmSettings: alarmSettings);
//       debugPrint("✅ Test alarm scheduled for 5 seconds from now");
//     } catch (e) {
//       debugPrint("❌ Failed to schedule test alarm: $e");
//     }
//   }
// }