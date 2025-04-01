import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.id, 
      this.name, 
      this.phone, 
      this.email, 
      this.dob, 
      this.image, 
      this.gender,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    dob = json['dob'];
    image = json['image'];
    gender = json['gender'];
  }
  num? id;
  String? name;
  num? phone;
  String? email;
  String? dob;
  String? image;
  String? gender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['email'] = email;
    map['dob'] = dob;
    map['image'] = image;
    map['gender'] = gender;
    return map;
  }

}