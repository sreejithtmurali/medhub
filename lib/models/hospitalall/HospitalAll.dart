import 'Data.dart';
import 'dart:convert';

HospitalAll hospitalAllFromJson(String str) => HospitalAll.fromJson(json.decode(str));
String hospitalAllToJson(HospitalAll data) => json.encode(data.toJson());
class HospitalAll {
  HospitalAll({
      this.status, 
      this.data,});

  HospitalAll.fromJson(dynamic json) {
    status = json['Status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Hospital.fromJson(v));
      });
    }
  }
  String? status;
  List<Hospital>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}