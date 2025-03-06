import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/emergency_contact.dart';
import '../../../services/emergency_contact_service.dart';

class MyEmergencyContactViewModel extends BaseViewModel {
  final NavigationService navigationService = locator<NavigationService>();
  final  contactService = locator<EmergencyContactService>();

  // Sample data - in a real app, this would come from a service
  List<EmergencyContact> _emergencyContacts = [
    EmergencyContact(
        id: '1',
        name: 'John Doe',
        relationship: 'Father',
        phoneNumber: '+1 123-456-7890',
        email: 'john.doe@example.com',
        priority: 1
    ),
    EmergencyContact(
        id: '2',
        name: 'Jane Doe',
        relationship: 'Mother',
        phoneNumber: '+1 987-654-3210',
        email: 'jane.doe@example.com',
        priority: 2
    ),
    EmergencyContact(
        id: '3',
        name: 'Dr. Smith',
        relationship: 'Family Doctor',
        phoneNumber: '+1 555-123-4567',
        email: 'dr.smith@hospital.com',
        priority: 3
    ),
  ];

  List<EmergencyContact> get emergencyContacts => _emergencyContacts;

  void navigateToAddContact() {
    // You would navigate to your add contact view
  navigationService.navigateTo(Routes.addEmergencyContactView);
    notifyListeners();
  }

  void editContact(EmergencyContact contact) {
    // Navigate to edit view with the contact details
    // _navigationService.navigateTo(
    //   Routes.addEmergencyContactView,
    //   arguments: AddEmergencyContactViewArguments(contact: contact)
    // );

    // For testing purposes, we'll just update the contact name
    final index = _emergencyContacts.indexWhere((c) => c.id == contact.id);
    if (index != -1) {
      _emergencyContacts[index] = EmergencyContact(
          id: contact.id,
          name: '${contact.name} (Edited)',
          relationship: contact.relationship,
          phoneNumber: contact.phoneNumber,
          email: contact.email,
          priority: contact.priority
      );
      notifyListeners();
    }
  }

  void deleteContact(EmergencyContact contact) {
    // Show confirmation dialog in a real app
    _emergencyContacts.removeWhere((c) => c.id == contact.id);
    notifyListeners();
  }

// In a real app, you would have methods to:
// 1. Load contacts from the service on init
// 2. Sort contacts by priority
// 3. Call a contact directly from the app
// 4. Send emergency notifications
}



