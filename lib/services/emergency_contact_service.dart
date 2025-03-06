import '../models/emergency_contact.dart';

class EmergencyContactService {
  List<EmergencyContact> _contacts = [];

  // Get all contacts
  List<EmergencyContact> getAllContacts() {
    return _contacts;
  }

  // Add a new contact
  Future<bool> addContact(EmergencyContact contact) async {
    try {
      // In a real app, you would save to local storage or backend
      _contacts.add(contact);
      return true;
    } catch (e) {
      print('Error adding contact: $e');
      return false;
    }
  }

  // Update an existing contact
  Future<bool> updateContact(EmergencyContact contact) async {
    try {
      final index = _contacts.indexWhere((c) => c.id == contact.id);
      if (index != -1) {
        _contacts[index] = contact;
        return true;
      }
      return false;
    } catch (e) {
      print('Error updating contact: $e');
      return false;
    }
  }

  // Delete a contact
  Future<bool> deleteContact(String id) async {
    try {
      _contacts.removeWhere((contact) => contact.id == id);
      return true;
    } catch (e) {
      print('Error deleting contact: $e');
      return false;
    }
  }

  // Get contact by ID
  EmergencyContact? getContactById(String id) {
    try {
      return _contacts.firstWhere((contact) => contact.id == id);
    } catch (e) {
      return null;
    }
  }

// In a real app, you would have methods for:
// 1. Loading contacts from storage on app start
// 2. Persisting contacts to storage on changes
// 3. Synchronizing with a backend if applicable
// 4. Sending emergency notifications to contacts
}