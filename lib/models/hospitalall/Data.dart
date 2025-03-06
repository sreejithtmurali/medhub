import '../getalldoctors/Data.dart';

import 'Facilities.dart';
import 'dart:convert';

Hospital HospitalFromJson(String str) => Hospital.fromJson(json.decode(str));
String HospitalToJson(Hospital Hospital) => json.encode(Hospital.toJson());
class Hospital {
  Hospital({
      this.id, 
      this.name, 
      this.location, 
      this.rating, 
      this.about, 
      this.image, 
      this.doctors, 
      this.facilities,});

  Hospital.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    rating = json['rating'];
    about = json['about'];
    image = json['image'];
    if (json['doctors'] != null) {
      doctors = [];
      json['doctors'].forEach((v) {
        doctors?.add(Doctor.fromJson(v));
      });
    }
    if (json['facilities'] != null) {
      facilities = [];
      json['facilities'].forEach((v) {
        facilities?.add(Facilities.fromJson(v));
      });
    }
  }
  num? id;
  String? name;
  String? location;
  num? rating;
  String? about;
  String? image;
  List<Doctor>? doctors;
  List<Facilities>? facilities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['location'] = location;
    map['rating'] = rating;
    map['about'] = about;
    map['image'] = image;
    if (doctors != null) {
      map['doctors'] = doctors?.map((v) => v.toJson()).toList();
    }
    if (facilities != null) {
      map['facilities'] = facilities?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}