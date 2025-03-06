import 'Data.dart';
import 'dart:convert';

MyPrescription myPrescriptionFromJson(String str) => MyPrescription.fromJson(json.decode(str));
String myPrescriptionToJson(MyPrescription data) => json.encode(data.toJson());
class MyPrescription {
  MyPrescription({
      this.status, 
      this.data,});

  MyPrescription.fromJson(dynamic json) {
    status = json['Status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Prescription.fromJson(v));
      });
    }
  }
  String? status;
  List<Prescription>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}