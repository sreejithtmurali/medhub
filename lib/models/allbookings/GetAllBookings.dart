import 'Doctor.dart';
import 'dart:convert';

GetAllBookings getAllBookingsFromJson(String str) => GetAllBookings.fromJson(json.decode(str));
String getAllBookingsToJson(GetAllBookings data) => json.encode(data.toJson());
class GetAllBookings {
  GetAllBookings({
      this.id, 
      this.doctor, 
      this.selectedDate, 
      this.selectedTime, 
      this.createdAt, 
      this.user,});

  GetAllBookings.fromJson(dynamic json) {
    id = json['id'];
    doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    selectedDate = json['selected_date'];
    selectedTime = json['selected_time'];
    createdAt = json['created_at'];
    user = json['user'];
  }
  num? id;
  Doctor? doctor;
  String? selectedDate;
  String? selectedTime;
  String? createdAt;
  num? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (doctor != null) {
      map['doctor'] = doctor?.toJson();
    }
    map['selected_date'] = selectedDate;
    map['selected_time'] = selectedTime;
    map['created_at'] = createdAt;
    map['user'] = user;
    return map;
  }

}