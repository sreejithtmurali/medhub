import 'package:flutter/material.dart';
import 'package:medhub/app/utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/emergency_contact.dart';
import '../../../models/getallemergency/Data.dart';
import '../../../services/emergency_contact_service.dart';

class MyEmergencyContactViewModel extends BaseViewModel {
  List<EmerContact>?emergencyContacts =[];

  init() async {
 emergencyContacts=   await apiService.getEmergencyContacts();
 notifyListeners();
  }
  void deleteContact(EmerContact contact) async{
  bool? s=await apiService.deleteEmergencyContact(contactId: int.parse(contact.id.toString()));
  if(s) {
    emergencyContacts?.removeWhere((c) => c.id == contact.id);
    notifyListeners();
  }
  }

  void navigateToAddContact() {
    navigationService.navigateTo(Routes.addEmergencyContactView);
  }

  String getPriorityLabel(String priority) {
    switch (priority) {

      case "1":
        return '(High)';
      case "2":
        return '(Medium)';
      case "3":
        return '(Low)';
      default:
        return '';
    }
  }

// In a real app, you would have methods to:
// 1. Load contacts from the service on init
// 2. Sort contacts by priority
// 3. Call a contact directly from the app
// 4. Send emergency notifications
}



