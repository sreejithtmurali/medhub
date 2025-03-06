import 'Data.dart';
import 'dart:convert';

ReminderAll reminderAllFromJson(String str) => ReminderAll.fromJson(json.decode(str));
String reminderAllToJson(ReminderAll data) => json.encode(data.toJson());
class ReminderAll {
  ReminderAll({
      this.status, 
      this.data,});

  ReminderAll.fromJson(dynamic json) {
    status = json['Status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Riminder.fromJson(v));
      });
    }
  }
  String? status;
  List<Riminder>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}