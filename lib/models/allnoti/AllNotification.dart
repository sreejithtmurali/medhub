import 'Data.dart';
import 'dart:convert';

AllNotification allNotificationFromJson(String str) => AllNotification.fromJson(json.decode(str));
String allNotificationToJson(AllNotification data) => json.encode(data.toJson());
class AllNotification {
  AllNotification({
      this.status, 
      this.data,});

  AllNotification.fromJson(dynamic json) {
    status = json['Status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Notification2.fromJson(v));
      });
    }
  }
  String? status;
  List<Notification2>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}