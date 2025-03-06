import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medhub/app/utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../models/reminder.dart';
import '../../../services/reminder_service.dart';
import '../../../services/notification_service.dart';

class AddReminderViewModel extends BaseViewModel {
  ReminderService _reminderService=ReminderService();
  NotificationService _notificationService=NotificationService();
  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController messageController = TextEditingController();

  // Form values
  bool _isPeriodic = false;
  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime _fromDate = DateTime.now();
  DateTime? _toDate;
  ReminderPriority _priority = ReminderPriority.medium;

  // ID for editing an existing reminder
  String? _reminderId;

  // Getters
  bool get isPeriodic => _isPeriodic;
  TimeOfDay get selectedTime => _selectedTime;
  DateTime get fromDate => _fromDate;
  DateTime? get toDate => _toDate;
  ReminderPriority get priority => _priority;

  // Initialize the view model, optionally with a reminder to edit
  void initialize(Reminder? reminderToEdit) {
    if (reminderToEdit != null) {
      _reminderId = reminderToEdit.id;
      messageController.text = reminderToEdit.message;
      _isPeriodic = reminderToEdit.isPeriodic;
      _selectedTime = TimeOfDay(hour: reminderToEdit.time.hour, minute: reminderToEdit.time.minute);
      _fromDate = reminderToEdit.fromDate;
      _toDate = reminderToEdit.toDate;
      _priority = reminderToEdit.priority;
    }
    notifyListeners();
  }

  // Setters
  void setIsPeriodic(bool value) {
    _isPeriodic = value;
    if (!_isPeriodic) {
      _toDate = null;
    } else if (_toDate == null) {
      // Default to 7 days from now for periodic reminders
      _toDate = _fromDate.add(const Duration(days: 7));
    }
    notifyListeners();
  }

  void selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.purple,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      _selectedTime = pickedTime;
      notifyListeners();
    }
  }

  void selectFromDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _fromDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.purple,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _fromDate) {
      _fromDate = pickedDate;
      // If to date is before from date, adjust it
      if (_toDate != null && _toDate!.isBefore(_fromDate)) {
        _toDate = _fromDate.add(const Duration(days: 7));
      }
      notifyListeners();
    }
  }

  void selectToDate(BuildContext context) async {
    if (!_isPeriodic) return;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _toDate ?? _fromDate.add(const Duration(days: 7)),
      firstDate: _fromDate,
      lastDate: _fromDate.add(const Duration(days: 365 * 5)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.purple,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      _toDate = pickedDate;
      notifyListeners();
    }
  }

  void setPriority(ReminderPriority value) {
    _priority = value;
    notifyListeners();
  }

  // Format time for display
  String formatTimeOfDay() {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, _selectedTime.hour, _selectedTime.minute);
    final format = DateFormat.jm();  // Format: 8:30 PM
    return format.format(dt);
  }

  // Format date for display
  String formatDate(DateTime date) {
    final format = DateFormat.yMMMd();  // Format: Jan 20, 2025
    return format.format(date);
  }

  // Save or update the reminder
  Future<void> saveReminder() async {
    if (formKey.currentState!.validate()) {
      setBusy(true);

      final reminder = Reminder(
        id: _reminderId,
        message: messageController.text.trim(),
        isPeriodic: _isPeriodic,
        time: DateTime(1, 1, 1, _selectedTime.hour, _selectedTime.minute),
        fromDate: _fromDate,
        toDate: _isPeriodic ? _toDate : null,
        priority: _priority,
      );

      if (_reminderId == null) {
        // Add new reminder
        await _reminderService.addReminder(reminder);
      } else {
        // Update existing reminder
        await _reminderService.updateReminder(reminder);

        // Cancel previous notification
        await _notificationService.cancelReminder(_reminderId.hashCode);
      }

      // Schedule notification
      await _notificationService.scheduleReminder(reminder);

      setBusy(false);
      navigationService.back();
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}