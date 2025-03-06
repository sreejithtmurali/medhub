import 'dart:convert';

Medicalreport medicalreportFromJson(String str) => Medicalreport.fromJson(json.decode(str));
String medicalreportToJson(Medicalreport data) => json.encode(data.toJson());
class Medicalreport {
  Medicalreport({
      this.data,});

  Medicalreport.fromJson(dynamic json) {
    data = json['data'];
  }
  String? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    return map;
  }

}