import 'dart:convert';
import 'dart:io';

import 'package:cross_file/src/types/interface.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/retry.dart';
import 'package:http/http.dart' as http;
import 'package:medhub/app/utils.dart';
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



      var  headers= {
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
        var res= ProfileUpdate.fromJson(jsonDecode(response.body));
        return res.data;
      } else {
        SmartDialog.dismiss();
        throw Exception('Failed to fetch profile. Please check your credentials.');
      }
    } catch (error) {
      SmartDialog.dismiss();
      throw Exception('Failed to login: $error');
    }
  }
  //-------------------------------
  Future<bool> Register(
      {required String Email,
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
      String fileName = profileImage!.path.split('/').last;
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
      if(profileImage!=null) {
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
  Future<void> addSchedule({
    required String name,
    required String startDate,
    required String endDate,
    required int timeInterval,
    required bool afterFood,
  }) async {
    var uri = Uri.parse('$baseUrl/profile-update/');
    var headers={
      "Authorization": "Bearer ${await getToken()}",
      "Content-Type": "application/json",
    };
    var json=jsonEncode({
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
    required String prescriptionDate}) async{

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
        "date": prescriptionDate??"",
      });
      // Add image file
      String fileName = prescriptionImage!.path.split('/').last;
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
      if(prescriptionImage!=null) {
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
  Future<List<Prescription>?>getallprescription()async{
    var uri = Uri.parse('$baseUrl/prescription/');
    var headers={
      "Authorization": "Bearer ${await getToken()}",
      "Content-Type": "application/json",
    };
    try{
      var resp=await http.get(uri,headers: headers);
      print("___________________");
      print(resp.body);
      if(resp.statusCode>=200&& resp.statusCode<=299){
        var json=jsonDecode(resp.body);
        var res=MyPrescription.fromJson(json);
        var list=res.data;
        return list;

      }
    }catch(e){
      print("ex::::::::::$e");
    }
  }

  // Method to get authentication token
  Future<String> getToken() async {
    var access=await userService.getAccessToken();
    return '$access'; // Replace with actual implementation
  }

}

enum ApiEnvironment {
  dev("http://192.168.1.48:8000"),
  prod("http://192.168.1.94:8000");
  // Generate a secure key and IV (Initialization Vector)

  const ApiEnvironment(this.baseUrl);

  final String baseUrl;
}
