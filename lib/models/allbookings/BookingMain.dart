import 'dart:convert';

import 'package:medhub/models/allbookings/GetAllBookings.dart';

BookingMain bookingMainFromJson(String str) => BookingMain.fromJson(json.decode(str));
String bookingMainToJson(BookingMain data) => json.encode(data.toJson());
class BookingMain {
  BookingMain({
      this.status, 
      this.data,});

  BookingMain.fromJson(Map json) {
    status = json['Status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(GetAllBookings.fromJson(v));
      });
    }
  }
  String? status;
  List<GetAllBookings>? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}