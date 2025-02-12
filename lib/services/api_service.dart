import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/retry.dart';
import 'package:http/http.dart' as http;
import 'package:medhub/models/Productsall/Products.dart';
import 'package:medhub/models/Productsall/RespProducts.dart';

import '../constants/app_strings.dart';
import '../models/User.dart';

class ApiService {
  static const environment = ApiEnvironment.dev;
  static const environment2 = ApiEnvironment.lumin;
  static String baseUrl = environment.baseUrl;
  static String baseUrl2 = environment2.baseUrl;
  Future<List<Products>?> fetchproducts() async {
    Uri url=Uri.parse('$baseUrl/products');
    var response=await http.get(url,headers: null);
    debugPrint(response.body);
    if(response.statusCode>=200 && response.statusCode<=299){
      var json=jsonDecode(response.body);
      var repproduct=RespProducts.fromJson(json);
      var list=repproduct.products;
      return list;
      // List jsonn=jsonDecode(response.body) as List;
    }
  }

  Future<User?> login({required String email, required String password}) async {
    print("calling api");
    Uri url = Uri.parse("$baseUrl2/login");
    final header = {
      "accept": "application/json",
      "Content-Type": "application/json"
    };

    final body = jsonEncode({"email": "$email", "password": "$password"});

    try {
      final response = await http.post(url, headers: header, body: body);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        print("${response.body}");
        var json = jsonDecode(response.body);
        var user = User.fromJson(json);
        return user;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

enum ApiEnvironment {
  dev("https://dummyjson.com"),
  prod("https://dummyjson.com"),
  lumin("https://freeapi.luminartechnohub.com");

  const ApiEnvironment(this.baseUrl);

  final String baseUrl;
}
