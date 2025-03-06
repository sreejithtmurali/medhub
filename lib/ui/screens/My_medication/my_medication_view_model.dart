import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../services/medicationservice.dart';
import '../../../models/medication.dart';

class ViewAllMedicationsModel extends BaseViewModel {
  var medications=[
    Medication(name: "paracetamol", startDate: DateTime.now(), endDate: DateTime.now(), timeInterval: "1-1-1", afterFood: true),
    Medication(name: "Trimol", startDate: DateTime.now(), endDate: DateTime.now(), timeInterval: "1-1-1", afterFood: true),
    Medication(name: "Cetricen", startDate: DateTime.now(), endDate: DateTime.now(), timeInterval: "1-1-1", afterFood: true),
  ];

  deleteMedication(Medication s) {
    medications.remove(s);
    notifyListeners();
  }
}