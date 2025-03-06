import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../app/utils.dart';
import '../../../models/reminder.dart';
import '../../../services/notification_service.dart';
import '../../../services/reminder_service.dart';

class MyRemindersViewModel extends BaseViewModel {
  ReminderService _reminderService=ReminderService();
  NotificationService _notificationService=NotificationService();


  List<Reminder> get reminders => _reminderService.reminders;

  Future<void> init() async {
    setBusy(true);
    await _reminderService.init();
    await _notificationService.init();
    setBusy(false);
  }

  void navigateToAddReminder() {
    navigationService.navigateTo(Routes.addReminderView);
  }

  Future<void> deleteReminder(String id) async {
    await _reminderService.deleteReminder(id);
    await _notificationService.cancelReminder(id.hashCode);
    rebuildUi();
  }

  initialize() {}
}


