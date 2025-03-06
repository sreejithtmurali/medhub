import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/reminder.dart';

class ReminderService {
  static const String _storageKey = 'reminders';
  List<Reminder> _reminders = [];

  List<Reminder> get reminders => _reminders;

  Future<void> init() async {
    await loadReminders();
  }

  Future<void> loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final remindersJson = prefs.getStringList(_storageKey) ?? [];

    _reminders = remindersJson
        .map((json) => Reminder.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> saveReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final remindersJson = _reminders
        .map((reminder) => jsonEncode(reminder.toJson()))
        .toList();

    await prefs.setStringList(_storageKey, remindersJson);
  }

  Future<void> addReminder(Reminder reminder) async {
    _reminders.add(reminder);
    await saveReminders();
  }

  Future<void> deleteReminder(String id) async {
    _reminders.removeWhere((reminder) => reminder.id == id);
    await saveReminders();
  }

  Future<void> updateReminder(Reminder updatedReminder) async {
    final index = _reminders.indexWhere((r) => r.id == updatedReminder.id);
    if (index != -1) {
      _reminders[index] = updatedReminder;
      await saveReminders();
    }
  }
}
