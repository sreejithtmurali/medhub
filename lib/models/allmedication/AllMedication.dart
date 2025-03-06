import 'Data.dart';
import 'dart:convert';

AllMedication allMedicationFromJson(String str) => AllMedication.fromJson(json.decode(str));
String allMedicationToJson(AllMedication data) => json.encode(data.toJson());
class AllMedication {
  AllMedication({
      this.status, 
      this.data,});

  AllMedication.fromJson(dynamic json) {
    status = json['Status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Medication.fromJson(v));
      });
    }
  }
  String? status;
  List<Medication>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}