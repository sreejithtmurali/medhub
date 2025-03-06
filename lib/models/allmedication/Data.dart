import 'dart:convert';

Medication MedicationFromJson(String str) => Medication.fromJson(json.decode(str));
String MedicationToJson(Medication medication) => json.encode(medication.toJson());

class Medication {
  Medication({
    this.id,
    this.name,
    this.startDate,
    this.endDate,
    this.timeInterval,
    this.afterFood,
    this.user,
  });

  Medication.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];

    // Proper DateTime parsing with null safety
    startDate = json['start_date'] != null
        ? DateTime.tryParse(json['start_date'].toString())
        : null;

    endDate = json['end_date'] != null
        ? DateTime.tryParse(json['end_date'].toString())
        : null;

    timeInterval = json['time_interval']?.toString();
    afterFood = json['after_food'] is bool
        ? json['after_food']
        : (json['after_food'] == 'true' || json['after_food'] == 1);
    user = json['user']?.toString();
  }

  num? id;
  String? name;
  DateTime? startDate;
  DateTime? endDate;
  String? timeInterval;
  bool? afterFood;
  String? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;

    // Proper DateTime serialization
    map['start_date'] = startDate?.toIso8601String();
    map['end_date'] = endDate?.toIso8601String();
    map['time_interval'] = timeInterval;
    map['after_food'] = afterFood;
    map['user'] = user;
    return map;
  }
}