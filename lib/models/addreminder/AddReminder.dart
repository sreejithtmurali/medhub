import 'Data.dart';
import 'dart:convert';

AddReminder addReminderFromJson(String str) => AddReminder.fromJson(json.decode(str));
String addReminderToJson(AddReminder data) => json.encode(data.toJson());
class AddReminder {
  AddReminder({
      this.status, 
      this.msg, 
      this.data,});

  AddReminder.fromJson(dynamic json) {
    status = json['Status'];
    msg = json['Msg'];
    data = json['data'] != null ? Reminder.fromJson(json['data']) : null;
  }
  String? status;
  String? msg;
  Reminder? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['Msg'] = msg;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}