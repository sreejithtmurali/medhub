class EmergencyContact {
  final String id;
  final String name;
  final String relationship;
  final String phoneNumber;
  final String? email;
  final int priority;

  EmergencyContact({
    required this.id,
    required this.name,
    required this.relationship,
    required this.phoneNumber,
    this.email,
    required this.priority
  });

  // Constructor to create a contact from JSON
  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      id: json['id'],
      name: json['name'],
      relationship: json['relationship'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      priority: json['priority'],
    );
  }

  // Convert contact to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'relationship': relationship,
      'phoneNumber': phoneNumber,
      'email': email,
      'priority': priority,
    };
  }

  // Create a copy of this contact with some fields updated
  EmergencyContact copyWith({
    String? id,
    String? name,
    String? relationship,
    String? phoneNumber,
    String? email,
    int? priority,
  }) {
    return EmergencyContact(
      id: id ?? this.id,
      name: name ?? this.name,
      relationship: relationship ?? this.relationship,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      priority: priority ?? this.priority,
    );
  }
}// TODO Implement this library.