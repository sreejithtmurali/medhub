import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class SOSViewModel extends BaseViewModel {
  final LocationService _locationService = LocationService();
  String emergencyContact = "911"; // Replace with actual emergency contact
  String ambulanceNumber = "102"; // Replace with actual ambulance number
  String? errorMessage;

  Future<void> makeEmergencyCall() async {
    try {
      final Uri url = Uri.parse('tel:$emergencyContact');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch emergency call';
      }
    } catch (e) {
      errorMessage = 'Failed to make emergency call';
      notifyListeners();
    }
  }

  Future<void> callAmbulance() async {
    try {
      final Uri url = Uri.parse('tel:$ambulanceNumber');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch ambulance call';
      }
    } catch (e) {
      errorMessage = 'Failed to call ambulance';
      notifyListeners();
    }
  }

  Future<void> shareLocationWithMedicalHistory() async {
    try {
      setBusy(true);
      errorMessage = null;

      // Get current location
      Position position = await _locationService.determinePosition();
      String locationMessage =
          'Emergency! I need help! My current location is:\n'
          '📍 Latitude: ${position.latitude}\n'
          '📍 Longitude: ${position.longitude}\n'
          '🔗 Google Maps: https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}\n\n'
          '📄 Attached: My Medical History PDF:https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf\n share this file with doctor';

      // Download the medical history PDF
      File medicalHistoryFile = await _downloadMedicalHistoryPdf(
          'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf');

      // Share both the PDF file and location message
      await Share.share(
        locationMessage// Attach location message
      );
    } catch (e) {
      errorMessage = _handleLocationError(e.toString());
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }

// Function to download the PDF
  Future<File> _downloadMedicalHistoryPdf(String url) async {
    final Directory tempDir = await getTemporaryDirectory();
    final String filePath = '${tempDir.path}/medical_history.pdf';
    final File file = File(filePath);

    try {
      Response response = await Dio().download(url, filePath);
      if (response.statusCode == 200) {
        return file;
      } else {
        throw Exception("Failed to download PDF");
      }
    } catch (e) {
      throw Exception("Error downloading PDF: $e");
    }
  }

  String _handleLocationError(String error) {
    if (error.contains('Location services are disabled')) {
      return 'Please enable location services in settings';
    } else if (error.contains('permissions are denied')) {
      return 'Location permission is required';
    } else if (error.contains('permanently denied')) {
      return 'Location permissions are permanently denied. Please enable in settings';
    }
    return 'Failed to get location';
  }

  void openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  void openAppSettings() async {
    await Geolocator.openAppSettings();
  }
}

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied';
    }

    return await Geolocator.getCurrentPosition();
  }
}
