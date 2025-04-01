import 'dart:convert';

Notification2 Notification2FromJson(String str) => Notification2.fromJson(json.decode(str));
String Notification2ToJson(Notification2 Notification2) => json.encode(Notification2.toJson());
class Notification2 {
  Notification2({
      this.id, 
      this.message, 
      this.createdAt,});

  Notification2.fromJson(dynamic json) {
    id = json['id'];
    message = json['message'];
    createdAt = json['created_at'];
  }
  num? id;
  String? message;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['message'] = message;
    map['created_at'] = createdAt;
    return map;
  }

}