class Hospital {
  final String id;
  final String name;
  final String imageUrl;
  final String address;
  final double rating;
  final int reviews;
  final String about;
  final List<String> facilities;
  final bool isFavorite;

  Hospital({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.address,
    required this.rating,
    required this.reviews,
    required this.about,
    required this.facilities,
    this.isFavorite = false,
  });
}

class Doctor {
  final String id;
  final String name;
  final String specialization;
  final String imageUrl;
  final double rating;
  final int reviews;
  final bool isAvailable;

  Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
    this.isAvailable = true,
  });
}