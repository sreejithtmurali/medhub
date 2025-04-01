

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/reminder.dart';
import '../../../services/reminder_service.dart';
import '../../../services/api_service.dart';

class AddReminderViewModel extends BaseViewModel {
  final _reminderService = locator<ReminderService>();
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();

  final formKey = GlobalKey<FormState>();
  final TextEditingController messageController = TextEditingController();

  bool _isPeriodic = false;
  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime _fromDate = DateTime.now();
  DateTime? _toDate;
  ReminderPriority _priority = ReminderPriority.medium;
  String? _notes;
  String? _reminderId;

  bool get isPeriodic => _isPeriodic;
  TimeOfDay get selectedTime => _selectedTime;
  DateTime get fromDate => _fromDate;
  DateTime? get toDate => _toDate;
  ReminderPriority get priority => _priority;
  String? get notes => _notes;

  void initialize(Reminder? reminderToEdit) {
    if (reminderToEdit != null) {
      _reminderId = reminderToEdit.id;
      messageController.text = reminderToEdit.message ?? '';
      _isPeriodic = reminderToEdit.isPeriodic ?? false;

      if (reminderToEdit.time != null) {
        final timeParts = reminderToEdit.time!.toString().split(':');
        if (timeParts.length >= 2) {
          _selectedTime = TimeOfDay(
            hour: int.parse(timeParts[0]),
            minute: int.parse(timeParts[1]),
          );
        }
      }

      if (reminderToEdit.fromDate != null) {
        _fromDate = DateTime.parse(reminderToEdit.fromDate!.toString());
      }

      if (reminderToEdit.toDate != null) {
        _toDate = DateTime.parse(reminderToEdit.toDate!.toString());
      }
    }
    notifyListeners();
  }

  void setNotes(String? value) {
    _notes = value;
    notifyListeners

      ();
  }

  void setIsPeriodic(bool value) {
    _isPeriodic = value;
    if (!_isPeriodic) {
      _toDate = null;
    } else if (_toDate == null) {
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
              primary: Colors.blue,
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
              primary: Colors.blue,
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
              primary: Colors.blue,
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

  String formatTimeOfDay() {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, _selectedTime.hour, _selectedTime.minute);
    final format = DateFormat('HH:mm');
    return format.format(dt);
  }

  String formatDate(DateTime date) {
    final format = DateFormat.yMMMd();
    return format.format(date);
  }

  Future<void> saveReminder() async {
    if (formKey.currentState!.validate()) {
      setBusy(true);

      try {
        String formattedFromDate = DateFormat('yyyy-MM-dd').format(_fromDate);
        String? formattedToDate = _toDate != null
            ? DateFormat('yyyy-MM-dd').format(_toDate!)
            : null;

        Map<String, int> timeMap = {
          'hour': _selectedTime.hour,
          'minute': _selectedTime.minute,
          'second': 0
        };

        var reminder = await apiService.addReminder(
          message: messageController.text.trim(),
          repeat: _isPeriodic,
          time: timeMap,
          from_date: formattedFromDate,
          to_date: formattedToDate,
        );

        if (reminder != null) {
          messageController.clear();
          _isPeriodic = false;

          print('Scheduling reminder with ID: ${reminder.id}');
          print('Message: ${reminder.message}');
          print('Time: ${reminder.time}');
          print('From Date: ${reminder.fromDate}');
          print('To Date: ${reminder.toDate}');


          await _reminderService.scheduleReminder(reminder);
        }

        navigationService.back();
      } catch (e) {
        print('Error saving reminder: $e');
      } finally {
        setBusy(false);
      }
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:medhub/app/utils.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';
//
// import '../../../app/app.locator.dart';
// import '../../../app/app.router.dart';
// import '../../../models/reminder.dart';
// import '../../../models/allriminders/Data.dart';
// import '../../../services/reminder_service.dart';
// import '../../../services/notification_service.dart';
// import '../../../services/api_service.dart';
//
// class AddReminderViewModel extends BaseViewModel {
//   // Service dependencies
//   final _reminderService = locator<ReminderService>();
//
//   // Form key for validation
//   final formKey = GlobalKey<FormState>();
//
//   // Controllers
//   final TextEditingController messageController = TextEditingController();
//
//   // Form values
//   bool _isPeriodic = false;
//   TimeOfDay _selectedTime = TimeOfDay.now();
//   DateTime _fromDate = DateTime.now();
//   DateTime? _toDate;
//   ReminderPriority _priority = ReminderPriority.medium;
//   String? _notes;
//
//   // ID for editing an existing reminder
//   num? _reminderId;
//
//   // Getters
//   bool get isPeriodic => _isPeriodic;
//   TimeOfDay get selectedTime => _selectedTime;
//   DateTime get fromDate => _fromDate;
//   DateTime? get toDate => _toDate;
//   ReminderPriority get priority => _priority;
//   String? get notes => _notes;
//
//   // Initialize the view model, optionally with a reminder to edit
//   void initialize(Riminder? reminderToEdit) {
//     if (reminderToEdit != null) {
//       _reminderId = reminderToEdit.id;
//       messageController.text = reminderToEdit.message ?? '';
//       _isPeriodic = reminderToEdit.repeat ?? false;
//
//       // Parse time from string - assuming format is "HH:mm"
//       if (reminderToEdit.time != null) {
//         final timeParts = reminderToEdit.time!.split(':');
//         if (timeParts.length >= 2) {
//           _selectedTime = TimeOfDay(
//               hour: int.parse(timeParts[0]),
//               minute: int.parse(timeParts[1])
//           );
//         }
//       }
//
//       // Parse dates
//       if (reminderToEdit.fromDate != null) {
//         _fromDate = DateTime.parse(reminderToEdit.fromDate!);
//       }
//
//       if (reminderToEdit.toDate != null && reminderToEdit.toDate!.isNotEmpty) {
//         _toDate = DateTime.parse(reminderToEdit.toDate!);
//       }
//     }
//     notifyListeners();
//   }
//
//   // Setters
//   void setNotes(String? value) {
//     _notes = value;
//     notifyListeners();
//   }
//
//   void setIsPeriodic(bool value) {
//     _isPeriodic = value;
//     if (!_isPeriodic) {
//       _toDate = null;
//     } else if (_toDate == null) {
//       // Default to 7 days from now for periodic reminders
//       _toDate = _fromDate.add(const Duration(days: 7));
//     }
//     notifyListeners();
//   }
//
//   void selectTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: _selectedTime,
//       builder: (context, child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: Colors.blue,
//               onPrimary: Colors.white,
//               onSurface: Colors.black,
//             ),
//             timePickerTheme: TimePickerThemeData(
//               dialHandColor: Colors.blue,
//             ),
//           ),
//           child: child!,
//         );
//       },
//       useRootNavigator: false,
//       helpText: 'Select Time',
//       cancelText: 'Cancel',
//       confirmText: 'OK',
//     );
//
//     if (pickedTime != null && pickedTime != _selectedTime) {
//       _selectedTime = pickedTime;
//       notifyListeners();
//     }
//   }
//
//   void selectFromDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _fromDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
//       builder: (context, child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: Colors.blue,
//               onPrimary: Colors.white,
//               onSurface: Colors.black,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (pickedDate != null && pickedDate != _fromDate) {
//       _fromDate = pickedDate;
//       // If to date is before from date, adjust it
//       if (_toDate != null && _toDate!.isBefore(_fromDate)) {
//         _toDate = _fromDate.add(const Duration(days: 7));
//       }
//       notifyListeners();
//     }
//   }
//
//   void selectToDate(BuildContext context) async {
//     if (!_isPeriodic) return;
//
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _toDate ?? _fromDate.add(const Duration(days: 7)),
//       firstDate: _fromDate,
//       lastDate: _fromDate.add(const Duration(days: 365 * 5)),
//       builder: (context, child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: Colors.blue,
//               onPrimary: Colors.white,
//               onSurface: Colors.black,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (pickedDate != null) {
//       _toDate = pickedDate;
//       notifyListeners();
//     }
//   }
//
//   void setPriority(ReminderPriority value) {
//     _priority = value;
//     notifyListeners();
//   }
//
//   // Format time for display in 24-hour format
//   String formatTimeOfDay() {
//     final now = DateTime.now();
//     final dt = DateTime(now.year, now.month, now.day, _selectedTime.hour, _selectedTime.minute);
//     final format = DateFormat('HH:mm');
//     return format.format(dt);
//   }
//
//   // Format date for display
//   String formatDate(DateTime date) {
//     final format = DateFormat.yMMMd();
//     return format.format(date);
//   }
//
//   // Save or update the reminder
//   Future<void> saveReminder() async {
//     if (formKey.currentState!.validate()) {
//       setBusy(true);
//
//       try {
//         String formattedFromDate = DateFormat('yyyy-MM-dd').format(_fromDate);
//         String? formattedToDate = _toDate != null
//             ? DateFormat('yyyy-MM-dd').format(_toDate!)
//             : null;
//
//         Map<String, int> timeMap = {
//           'hour': _selectedTime.hour,
//           'minute': _selectedTime.minute,
//           'second': 0
//         };
//
//         var reminder = await apiService.addReminder(
//           message: messageController.text.trim(),
//           repeat: _isPeriodic,
//           time: timeMap,
//           from_date: formattedFromDate,
//           to_date: formattedToDate,
//         );
//
//         if (reminder != null) {
//           messageController.clear();
//           _isPeriodic = false;
//
//           // Debug print
//           print('Scheduling reminder with ID: ${reminder.id}');
//           print('Message: ${reminder.message}');
//           print('Time: ${reminder.time}');
//           print('From Date: ${reminder.fromDate}');
//           print('To Date: ${reminder.toDate}');
//
//           await _reminderService.scheduleReminder(reminder);
//         }
//
//         navigationService.back();
//       } catch (e) {
//         print('Error saving reminder: $e');
//       } finally {
//         setBusy(false);
//       }
//     }
//   }
//   // Future<void> saveReminder() async {
//   //   if (formKey.currentState!.validate()) {
//   //     setBusy(true);
//   //
//   //     try {
//   //       // Format dates to 'YYYY-MM-DD'
//   //       String formattedFromDate = DateFormat('yyyy-MM-dd').format(_fromDate);
//   //       String? formattedToDate = _toDate != null ? DateFormat('yyyy-MM-dd').format(_toDate!) : null;
//   //
//   //       // Prepare time data for API
//   //       Map<String, int> timeMap = {
//   //         'hour': _selectedTime.hour,
//   //         'minute': _selectedTime.minute,
//   //         'second': 0
//   //       };
//   //
//   //       // Call API to add reminder
//   //      var s= await apiService.addReminder(
//   //         message: messageController.text.trim(),
//   //         repeat: _isPeriodic,
//   //         time: timeMap,
//   //         from_date: formattedFromDate,
//   //         to_date: formattedToDate,
//   //       );
//   //      if(s!=null){
//   //        messageController.clear();
//   //        _isPeriodic=false;
//   //        await _reminderService.scheduleReminder(s );
//   //      }
//   //
//   //       navigationService.back();
//   //     } catch (e) {
//   //       print('Error saving reminder: $e');
//   //     } finally {
//   //       setBusy(false);
//   //     }
//   //   }
//   // }
//
//   @override
//   void dispose() {
//     messageController.dispose();
//     super.dispose();
//   }
// }