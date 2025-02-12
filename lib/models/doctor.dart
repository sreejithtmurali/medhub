import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DoctorProfileModel {
  final int ?id;
  final String name;
  final String specialization;
  final String imageUrl;
  final double rating;
  final int reviews;
  final int patients;
  final int experience;
  final String about;
  final bool isFavorite;

  DoctorProfileModel({
    this.id,
    required this.name,
    required this.specialization,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
    required this.patients,
    required this.experience,
    required this.about,
    this.isFavorite = false,
  });
}

class DoctorProfileViewModel extends BaseViewModel {
  DoctorProfileModel _doctor = DoctorProfileModel(
    name: "Dr. Ali Uzair",
    specialization: "Cardiologist and Surgeon",
    imageUrl: "assets/doctor_image.jpg",
    rating: 4.9,
    reviews: 90,
    patients: 116,
    experience: 3,
    about: "He is one of the top most cardiologist specialist in Crist Hospital in London, UK. He achieved several awards for her wonderful contribution.",
    isFavorite: false,
  );

  DoctorProfileModel get doctor => _doctor;
  bool get isFavorite => _doctor.isFavorite;

  void toggleFavorite() {
    _doctor = DoctorProfileModel(
      name: _doctor.name,
      specialization: _doctor.specialization,
      imageUrl: _doctor.imageUrl,
      rating: _doctor.rating,
      reviews: _doctor.reviews,
      patients: _doctor.patients,
      experience: _doctor.experience,
      about: _doctor.about,
      isFavorite: !_doctor.isFavorite,
    );
    notifyListeners();
  }

  void bookAppointment() {
    // Implement booking logic
    print('Booking appointment with ${_doctor.name}');
  }
}