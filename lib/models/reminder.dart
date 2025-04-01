import 'package:uuid/uuid.dart';

enum ReminderPriority { low, medium, high }

class Reminder {
  final String id;
  final String message;
  final bool isPeriodic;
  final DateTime time;
  final DateTime fromDate;
  final DateTime toDate; // Optional for non-periodic reminders
  final ReminderPriority priority;

  Reminder({
    String? id,
    required this.message,
    required this.isPeriodic,
    required this.time,
    required this.fromDate,
    required this.toDate,
    required this.priority,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'isPeriodic': isPeriodic,
      'time': time.toIso8601String(),
      'fromDate': fromDate.toIso8601String(),
      'toDate': toDate.toIso8601String(),
      'priority': priority.index,
    };
  }

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      message: json['message'],
      isPeriodic: json['isPeriodic'],
      time: DateTime.parse(json['time']),
      fromDate: DateTime.parse(json['fromDate']),
      toDate: DateTime.parse(json['toDate']) ,
      priority: ReminderPriority.values[json['priority']],
    );
  }
}