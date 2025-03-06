import 'Data.dart';
import 'dart:convert';

ProfileUpdate profileUpdateFromJson(String str) => ProfileUpdate.fromJson(json.decode(str));
String profileUpdateToJson(ProfileUpdate data) => json.encode(data.toJson());
class ProfileUpdate {
  ProfileUpdate({
      this.status, 
      this.data,});

  ProfileUpdate.fromJson(dynamic json) {
    status = json['Status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}