import 'dart:convert';

Prescription PrescriptionFromJson(String str) => Prescription.fromJson(json.decode(str));
String PrescriptionToJson(Prescription Prescription) => json.encode(Prescription.toJson());
class Prescription {
  Prescription({
      this.id, 
      this.image, 
      this.doctor, 
      this.date, 
      this.user,});

  Prescription.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    doctor = json['doctor'];
    date = json['date'];
    user = json['user'];
  }
  num? id;
  String? image;
  String? doctor;
  String? date;
  String? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['doctor'] = doctor;
    map['date'] = date;
    map['user'] = user;
    return map;
  }

}