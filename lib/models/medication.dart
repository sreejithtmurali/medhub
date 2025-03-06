class Medication {
  String? id;
  String name;
  DateTime startDate;
  DateTime endDate;
  String timeInterval;
  bool afterFood;

  Medication({
    this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.timeInterval,
    required this.afterFood,
  });

  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'time_interval': timeInterval,
      'after_food': afterFood,
    };
  }

  // Create from Map
  factory Medication.fromMap(Map<String, dynamic> map) {
    return Medication(
      id: map['id'],
      name: map['name'],
      startDate: DateTime.parse(map['start_date']),
      endDate: DateTime.parse(map['end_date']),
      timeInterval: map['time_interval'],
      afterFood: map['after_food'],
    );
  }
}
