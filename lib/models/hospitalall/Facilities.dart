import 'dart:convert';

Facilities facilitiesFromJson(String str) => Facilities.fromJson(json.decode(str));
String facilitiesToJson(Facilities data) => json.encode(data.toJson());
class Facilities {
  Facilities({
      this.id, 
      this.facility, 
      this.createdAt, 
      this.hospital,});

  Facilities.fromJson(dynamic json) {
    id = json['id'];
    facility = json['facility'];
    createdAt = json['created_at'];
    hospital = json['hospital'];
  }
  num? id;
  String? facility;
  String? createdAt;
  num? hospital;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['facility'] = facility;
    map['created_at'] = createdAt;
    map['hospital'] = hospital;
    return map;
  }

}