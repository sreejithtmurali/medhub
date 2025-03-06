import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../app/utils.dart';
import '../../../models/allriminders/Data.dart';
import '../../../models/reminder.dart';
import '../../../services/notification_service.dart';
import '../../../services/reminder_service.dart';

class MyRemindersViewModel extends BaseViewModel {
  List<Riminder>? reminders=[];
  Future<void> init() async {
    setBusy(true);
    reminders=await apiService.getallrimiders();
    setBusy(false);
    notifyListeners();
  }

  void navigateToAddReminder() {
    navigationService.navigateTo(Routes.addReminderView);
  }

  Future<void> deleteReminder(num id) async {
   bool? s=await apiService.deleteReminder(id:id);
   if(s==true) {
     init();
     rebuildUi();
   }
   notifyListeners();
  }


}


