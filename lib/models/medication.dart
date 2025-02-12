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
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'timeInterval': timeInterval,
      'afterFood': afterFood,
    };
  }

  // Create from Map
  factory Medication.fromMap(Map<String, dynamic> map) {
    return Medication(
      id: map['id'],
      name: map['name'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      timeInterval: map['timeInterval'],
      afterFood: map['afterFood'],
    );
  }
}
