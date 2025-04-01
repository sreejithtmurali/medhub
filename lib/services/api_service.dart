import 'dart:convert';
import 'dart:io';

import 'package:cross_file/src/types/interface.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/retry.dart';
import 'package:http/http.dart' as http;
import 'package:medhub/app/utils.dart';
import 'package:medhub/models/allnoti/Data.dart';
import 'package:medhub/models/addreminder/AddReminder.dart';
import 'package:medhub/models/addreminder/Data.dart';
import 'package:medhub/models/allbookings/BookingMain.dart';
import 'package:medhub/models/allbookings/GetAllBookings.dart';
import 'package:medhub/models/allmedication/AllMedication.dart';
import 'package:medhub/models/allmedication/Data.dart';
import 'package:medhub/models/allnoti/AllNotification.dart';
import 'package:medhub/models/allnoti/Data.dart';
import 'package:medhub/models/allriminders/ReminderAll.dart';
import 'package:medhub/models/getalldoctors/GetAllDoctors.dart';
import 'package:medhub/models/getallemergency/Data.dart';
import 'package:medhub/models/getallemergency/EmergencyContacts.dart';
import 'package:medhub/models/hospitalall/Data.dart';
import 'package:medhub/models/hospitalall/HospitalAll.dart';
import 'package:medhub/models/mediclreport/Medicalreport.dart';
import 'package:medhub/models/mypres/Data.dart';
import 'package:medhub/models/mypres/MyPrescription.dart';
import 'package:medhub/models/profileupdate/Data.dart';
import 'package:medhub/models/profileupdate/ProfileUpdate.dart';
import 'package:medhub/services/user_service.dart';
import 'package:medhub/ui/screens/MyPrescription/myprescriptions.dart';


import '../app/app.locator.dart';
import '../constants/app_strings.dart';
import '../models/User.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../models/allriminders/Data.dart';
import '../models/getalldoctors/Data.dart';


class ApiService {
  static const environment = ApiEnvironment.dev;

  static String baseUrl = environment.baseUrl;
  static String baseUrlApi = "$baseUrl/public/api";
  static String baseUrlImage = "$baseUrl/public/storage";


  var client = RetryClient(
    http.Client(),
    whenError: (onError, stackTrace) {
      if (onError.toString().contains(AppStrings.connectionClosedError)) {
        debugPrint("Retring....");
        return true;
      }
      return false;
    },
  );
  Duration timeoutDuration = const Duration(seconds: 20);

  /*--------------------------login-----------------------------*/
  Future<User> login({
    required String email,
    required String password,
  }) async {
    SmartDialog.showLoading();
    final url = Uri.parse('$baseUrl/login/');

    final body = jsonEncode({
      "email": email,
      "password": password,
    });
    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json"
    };
    print("url:$url:::: body::: $body  ::: Header ::::$headers");
    try {
      final response = await http.post(url, headers: headers, body: body);
      print(response.body);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        print(response.body);

        //var user = User.fromJson(jsonDecode(response.body));
        SmartDialog.dismiss();
        return User.fromJson(jsonDecode(response.body));
      } else {
        SmartDialog.dismiss();
        throw Exception('Failed to login. Please check your credentials.');
      }
    } catch (error) {
      SmartDialog.dismiss();
      throw Exception('Failed to login: $error');
    }
  }

//--------------------------------------
  Future<Data?> profile() async {
    SmartDialog.showLoading();
    final url = Uri.parse('$baseUrl/profile/');


    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await getToken()}'
    };
    print("url:$url:::: body:::   ::: Header ::::$headers");
    try {
      final response = await http.get(url, headers: headers);
      print("profile:::::::::::${response.body}");
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        print(response.body);

        //var user = User.fromJson(jsonDecode(response.body));
        SmartDialog.dismiss();
        var res = ProfileUpdate.fromJson(jsonDecode(response.body));
        return res.data;
      } else {
        SmartDialog.dismiss();
        throw Exception(
            'Failed to fetch profile. Please check your credentials.');
      }
    } catch (error) {
      SmartDialog.dismiss();
      throw Exception('Failed to login: $error');
    }
  }

  //-------------------------------
  Future<bool> Register({required String Email,
    required String name,
    required String phone,
    required String password}) async {
    Uri url = Uri.parse("$baseUrl/registration/");
    var body = jsonEncode({
      "name": "$name",
      "phone": "$phone",
      "email": "$Email",
      "password": "$password"
    });
    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "X-CSRFTOKEN": "yv9gVqdhRtq5ygjoITO2fqSZ7Rj15rYd"
    };
    print("url:$url:::: body::: $body  ::: Header ::::$headers");
    try {
      final response = await http.post(url, body: body, headers: headers);
      print("rees:::::${response.body}");
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUserProfile(User user, {File? profileImage}) async {
    try {
      var uri = Uri.parse('$baseUrl/profile-update/');
      var request = http.MultipartRequest('PUT', uri);

      // Add authorization header
      String token = await getToken();
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      // Add user data fields
      request.fields.addAll({
        'name': user.name ?? '',
        'email': user.email ?? '',
        'phone': user.phone ?? '',
        'gender': user.gender ?? '',
        'dob': user.dob ?? '',
      });
      // Add image file
      String fileName = profileImage!
          .path
          .split('/')
          .last;
      String? mimeType = lookupMimeType(profileImage.path);
      MediaType mediaType = mimeType != null
          ? MediaType.parse(mimeType)
          : MediaType('image', 'jpeg');

      var imageStream = http.ByteStream(profileImage.openRead());
      var length = await profileImage.length();
      var multipartFile = http.MultipartFile(
        'image',
        imageStream,
        length,
        filename: fileName,
        contentType: mediaType,
      );
      if (profileImage != null) {
        request.files.add(multipartFile);
      }


      // Send request
      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Profile updated successfully');
        return true;
      } else {
        String errorMessage = await response.stream.bytesToString();
        print('Failed to update profile: $errorMessage');
        return false;
      }
    } catch (e) {
      print('Error updating profile: $e');
      return false;
    }
  }

//---------------------------------
  Future<void> addmedication({
    required String name,
    required String startDate,
    required String endDate,
    required int timeInterval,
    required bool afterFood,
  }) async {
    var uri = Uri.parse('$baseUrl/profile-update/');
    var headers = {
      "Authorization": "Bearer ${await getToken()}",
      "Content-Type": "application/json",
    };
    var json = jsonEncode({
      "name": name,
      "start_date": startDate, // Format: YYYY-MM-DD
      "end_date": endDate, // Format: YYYY-MM-DD
      "time_interval": timeInterval,
      "after_food": afterFood,
    });
    try {
      final response = await http.post(
          Uri.parse(baseUrl),
          headers: headers,
          body: json
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print("Schedule added successfully: ${response.body}");
      } else {
        print("Failed to add schedule: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }


  Future<bool?> uploadPrescription({required File prescriptionImage,
    required String doctorName,
    required String prescriptionDate}) async {
    try {
      var uri = Uri.parse('$baseUrl/prescription/');
      var request = http.MultipartRequest('POST', uri);

      // Add authorization header
      String token = await getToken();
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      // Add user data fields
      request.fields.addAll({
        "doctor": doctorName, // Format: YYYY-MM-DD
        "date": prescriptionDate ?? "",
      });
      // Add image file
      String fileName = prescriptionImage!
          .path
          .split('/')
          .last;
      String? mimeType = lookupMimeType(prescriptionImage.path);
      MediaType mediaType = mimeType != null
          ? MediaType.parse(mimeType)
          : MediaType('image', 'jpeg');

      var imageStream = http.ByteStream(prescriptionImage.openRead());
      var length = await prescriptionImage.length();
      var multipartFile = http.MultipartFile(
        'image',
        imageStream,
        length,
        filename: fileName,
        contentType: mediaType,
      );
      if (prescriptionImage != null) {
        request.files.add(multipartFile);
      }


      // Send request
      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Prescription successfully');
        return true;
      } else {
        String errorMessage = await response.stream.bytesToString();
        print('Failed to upload Prescription: $errorMessage');
        return false;
      }
    } catch (e) {
      print('Error uploading Prescription: $e');
      return false;
    }
  }

  //============
  Future<List<Prescription>?> getallprescription() async {
    var uri = Uri.parse('$baseUrl/prescription/');
    var headers = {
      "Authorization": "Bearer ${await getToken()}",
      "Content-Type": "application/json",
    };
    try {
      var resp = await http.get(uri, headers: headers);
      print("___________________");
      print(resp.body);
      if (resp.statusCode >= 200 && resp.statusCode <= 299) {
        var json = jsonDecode(resp.body);
        var res = MyPrescription.fromJson(json);
        var list = res.data;
        return list;
      }
    } catch (e) {
      print("ex::::::::::$e");
    }
  }

//--------------------------------------------
  Future<bool> addEmergencyContact({
    required String name,
    required String relationship,
    required String phone,
    required String email,
    required int priority
  }) async {
    Uri url = Uri.parse("$baseUrl/contact/");

    var body = jsonEncode({
      "name": name,
      "relationship": relationship,
      "phone": phone,
      "email": email,
      "priority": priority
    });

    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await getToken()}"
    };

    print("URL: $url\nBody: $body\nHeaders: $headers");

    try {
      final response = await http.post(url, body: body, headers: headers);
      print("Response: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return true;
      } else {
        print(
            "Error adding emergency contact: ${response.statusCode} - ${response
                .body}");
        return false;
      }
    } catch (e) {
      print("Exception adding emergency contact: $e");
      return false;
    }
  }


  Future<List<EmerContact>?> getEmergencyContacts() async {
    Uri url = Uri.parse("$baseUrl/contact/");

    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await getToken()}"
    };

    print("URL: $url\nHeaders: $headers");

    try {
      final response = await http.get(url, headers: headers);
      print("Response : ${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var json = jsonDecode(response.body);
        var res = EmergencyContacts.fromJson(json);
        var list = res.data;
        return list;
      } else {
        print("Error getting emergency contacts: ${response
            .statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception getting emergency contacts: $e");
      return null;
    }
  }

  Future<bool> deleteEmergencyContact({required int contactId}) async {
    Uri url = Uri.parse("$baseUrl/contact/$contactId/");

    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await getToken()}"
    };

    print("URL: $url\nHeaders: $headers");

    try {
      final response = await http.delete(url, headers: headers);
      print("Response: ${response.statusCode} - ${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        print("Successfully deleted emergency contact with ID: $contactId");
        return true;
      } else {
        print("Error deleting emergency contact: ${response
            .statusCode} - ${response.body}");
        return false;
      }
    } catch (e) {
      print("Exception deleting emergency contact: $e");
      return false;
    }
  }

  Future<bool?> uploadMedications(List<Map<String, dynamic>> uploadData) async {
    Uri url = Uri.parse("$baseUrl/medication/");

    var body = jsonEncode({
      "data": uploadData,
    });
    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await getToken()}"
    };
    print("URL: $url\nBody: $body\nHeaders: $headers");
    try {
      final response = await http.post(url, body: body, headers: headers);
      print("Response: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return true;
      }
      else {
        print("Error adding medication : ${response.statusCode} - ${response
            .body}");
        return false;
      }
    } catch (e) {
      print("Exception adding medication : $e");
      return false;
    }
  }

  Future<List<Medication>?> getallMedications() async {
    Uri url = Uri.parse("$baseUrl/medication/");
    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await getToken()}"
    };

    print("URL: $url\n\nHeaders: $headers");

    try {
      final response = await http.get(url, headers: headers);
      print("all medications Response: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var json=jsonDecode(response.body);
        var res=AllMedication.fromJson(json);
        var list=res.data;
        return list;
      } else {
        print(
            "Error get medication : ${response.statusCode} - ${response.body}");

      }
    } catch (e) {
      print("Exception getting medication : $e");
    }
  }
  Future<bool?>deleteMediction(Medication s)async {
    Uri url = Uri.parse("$baseUrl/medication/${s.id}/");


    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await getToken()}"
    };
    print("URL: $url\n\nHeaders: $headers");
    try {
      final response = await http.delete(url,  headers: headers);
      print("Response: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 299)
      {
        return true;
      }
      else
      {
        print("Error adding reminder : ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (e)
    {
      print("Exception adding reminder : $e");
      return false;
    }




  }

  //----------------------------------
  Future<List<Doctor>?> getallDoctors() async {
    Uri url = Uri.parse("$baseUrl/doctors-all/");
    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await getToken()}"
    };

    print("URL: $url\n\nHeaders: $headers");

    try {
      final response = await http.get(url, headers: headers);
      print("all doctors-all Response: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var json = jsonDecode(response.body);
        var res = GetAllDoctors.fromJson(json);
        var list = res.data;
        return list;
      } else {
        print("Error get doctors-all : ${response.statusCode} - ${response
            .body}");
      }
    } catch (e) {
      print("Exception getting doctors-all : $e");
    }
  }

  //-----------------------------------
  Future<List<Hospital>?> getallHospitals() async {
    Uri url = Uri.parse("$baseUrl/hospitals-all/");
    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await getToken()}"
    };

    print("URL: $url\n\nHeaders: $headers");

    try {
      final response = await http.get(url, headers: headers);
      print("all hospitals-all Response: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var json = jsonDecode(response.body);
        var res = HospitalAll.fromJson(json);
        var list = res.data;
        return list;
      } else {
        print("Error get hospitals-all : ${response.statusCode} - ${response
            .body}");
      }
    } catch (e) {
      print("Exception getting hospitals-all : $e");
    }
  }

//--------------------
  Future<Reminder?> addReminder({required String message,
    required bool repeat, required Map time,
    required String from_date, String? to_date}) async {
    Uri url = Uri.parse("$baseUrl/reminder/");
    if (to_date == null) {
      to_date=from_date;
    }
    var body = jsonEncode({
      "message": message,
      "time": time,
      "repeat": repeat,
      "from_date": "${from_date}",
      "to_date": "${to_date}"
    });

    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await getToken()}"
    };
    print("URL: $url\nBody: $body\nHeaders: $headers");
    try {
      final response = await http.post(url, body: body, headers: headers);
      print("Response: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var json=jsonDecode(response.body);
        var res=AddReminder.fromJson(json);
        var rem=res.data;

        return rem;
      }
      else {
        print("Error adding reminder : ${response.statusCode} - ${response
            .body}");

      }
    } catch (e) {
      print("Exception adding reminder : $e");

    }
  }

  Future<bool?> deleteReminder({required num id}) async {
    Uri url = Uri.parse("$baseUrl/reminder/$id/");


    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await getToken()}"
    };
    print("URL: $url\n\nHeaders: $headers");
    try {
      final response = await http.delete(url, headers: headers);
      print("Response: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return true;
      }
      else {
        print("Error adding reminder : ${response.statusCode} - ${response
            .body}");
        return false;
      }
    } catch (e) {
      print("Exception adding reminder : $e");
      return false;
    }
  }

  Future<List<Riminder>?> getallrimiders() async {
    Uri url = Uri.parse("$baseUrl/reminder/");

    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await getToken()}"
    };
    print("URL: $url\nHeaders: $headers");
    try {
      final response = await http.get(url, headers: headers);
      print("Response: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var json = jsonDecode(response.body);
        var res = ReminderAll.fromJson(json);
        var list = res.data;
        return list;
      }
      else {
        print("Error getting reminder : ${response.statusCode} - ${response
            .body}");
      }
    } catch (e) {
      print("Exception getting reminder : $e");
    }
  }
  //-------------------
// Add this method to your ApiService class
// Add this method to your ApiService class
  Future<bool> mybooking({
    dynamic doctor,
    required DateTime selected_date,
    required String selected_time,
  }) async {
    try {
      // Convert DateTime to formatted string
      final formattedDate = "${selected_date.year}-${selected_date.month.toString().padLeft(2, '0')}-${selected_date.day.toString().padLeft(2, '0')}";

      final url = Uri.parse('$baseUrl/mybooking/');
      var headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${await getToken()}"
      };
      // Prepare request body
      final body = jsonEncode({
        'doctor': doctor,
        'selected_date': formattedDate,
        'selected_time': selected_time,
      });

      // Send POST request
      final response = await http.post(
        url,
        headers: headers,
        body:body,
      );
print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successful booking
        return true;
      } else {
        debugPrint('Booking failed. Status: ${response.statusCode}, Body: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Error in mybooking API call: $e');
      return false;
    }
  }
  Future<dynamic> getmybooking() async {
    try {

      final url = Uri.parse('$baseUrl/mybooking/');
      var headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${await getToken()}"
      };
      // Prepare request body


      // Send POST request
      final response = await http.get(
        url,
        headers: headers,

      );
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successful booking
        return true;
      } else {
        debugPrint('Booking failed. Status: ${response.statusCode}, Body: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Error in mybooking API call: $e');
      return false;
    }
  }
  Future<List<GetAllBookings>?>getallAppointment()async {
    Uri url = Uri.parse("$baseUrl/mybooking/");


    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await getToken()}"
    };
    print("mybooking URL: $url\n\nHeaders: $headers");
    try {
      final response = await http.get(url,  headers: headers);
      print("get all mybooking Response: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var json=jsonDecode(response.body);
        var res=BookingMain.fromJson(json);
        var data=res.data;
        return data;

      }
      else {
        print("Error in mybooking : ${response.statusCode} - ${response
            .body}");

      }
    } catch (e) {
      print("Exception in mybooking : $e");

    }
  }
  Future<bool?>deletebooking(num id)async {
    Uri url = Uri.parse("$baseUrl/mybooking/$id/");


    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await getToken()}"
    };
    print("delete mybooking URL: $url\n\nHeaders: $headers");
    try {
      final response = await http.delete(url,  headers: headers);
      print("delete all mybooking Response: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 299) {

        return true;

      }
      else {
        print("Error in mybooking : ${response.statusCode} - ${response
            .body}");
        return false;

      }
    } catch (e) {
      print("Exception in mybooking : $e");
      return false;

    }
  }

  Future<String?> getmyreport() async {
    try {

      final url = Uri.parse('$baseUrl/user-report/');
      var headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${await getToken()}"
      };
      // Prepare request body
      print(" report URL: $url\n\nHeaders: $headers");

      // Send POST request
      final response = await http.get(
        url,
        headers: headers,

      );
      print("pdf::${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successful booking
        var json=jsonDecode(response.body);
        var res=Medicalreport.fromJson(json);
        return res.data;
      } else {
        debugPrint('report failed. Status: ${response.statusCode}, Body: ${response.body}');

      }
    } catch (e) {
      debugPrint('Error in report API call: $e');
    }
  }
  // Method to get authentication token
  Future<String> getToken() async {
    var access = await userService.getAccessToken();
    return '$access'; // Replace with actual implementation
  }

  Future<List<Notification2>?> getNotifications()async {
    try {

      final url = Uri.parse('$baseUrl/notification/');
      var headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await getToken()}"
    };
    // Prepare request body
    print(" report URL: $url\n\nHeaders: $headers");

    // Send POST request
    final response = await http.get(
    url,
    headers: headers,

    );
    print("noti::${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json=jsonDecode(response.body);
      var res=AllNotification.fromJson(json);
      var list=res.data;
      return list;
    // Successful booking

    } else {
    debugPrint('noti failed. Status: ${response.statusCode}, Body: ${response.body}');

    }
    } catch (e) {
    debugPrint('Error in noti API call: $e');
    }
  }



}

enum ApiEnvironment {
  dev("http://192.168.1.35:8000"),
  prod("http://192.168.1.35:8000");
  // Generate a secure key and IV (Initialization Vector)

  const ApiEnvironment(this.baseUrl);

  final String baseUrl;
}
