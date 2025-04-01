import 'dart:convert';

Reminder ReminderFromJson(String str) => Reminder.fromJson(json.decode(str));
String ReminderToJson(Reminder Reminder) => json.encode(Reminder.toJson());
class Reminder {
  Reminder({
      this.id, 
      this.message, 
      this.repeat, 
      this.time, 
      this.fromDate, 
      this.toDate, 
      this.createdAt,});

  Reminder.fromJson(dynamic json) {
    id = json['id'];
    message = json['message'];
    repeat = json['repeat'];
    time = json['time'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    createdAt = json['created_at'];
  }
  num? id;
  String? message;
  bool? repeat;
  String? time;
  String? fromDate;
  String? toDate;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['message'] = message;
    map['repeat'] = repeat;
    map['time'] = time;
    map['from_date'] = fromDate;
    map['to_date'] = toDate;
    map['created_at'] = createdAt;
    return map;
  }

}