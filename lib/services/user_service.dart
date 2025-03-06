import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';
 // assuming you have the User class in a separate file

class UserService {
  // Keys for SharedPreferences
  static const String _userKey = 'user_data';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  // Save user data to SharedPreferences
   Future<bool> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = userToJson(user);

    // Store individual tokens for easier access
    await prefs.setString(_accessTokenKey, user.access ?? '');
    await prefs.setString(_refreshTokenKey, user.refresh ?? '');
    await prefs.setBool(_isLoggedInKey, true);

    return await prefs.setString(_userKey, userJson);
  }

  // Get user data from SharedPreferences
   Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(_userKey);

    if (userJson == null || userJson.isEmpty) {
      return null;
    }

    return userFromJson(userJson);
  }

  // Check if user is logged in
   Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Get access token
   Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  // Get refresh token
   Future<String?> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  // Update tokens
   Future<bool> updateTokens(String accessToken, String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User? user = await getUser();

    if (user != null) {
      user.access = accessToken;
      user.refresh = refreshToken;
      await prefs.setString(_userKey, userToJson(user));
    }

    await prefs.setString(_accessTokenKey, accessToken);
    return await prefs.setString(_refreshTokenKey, refreshToken);
  }

  // Update user profile
   Future<bool> updateUserProfile(User updatedUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User? currentUser = await getUser();

    if (currentUser != null) {
      // Preserve authentication tokens
      updatedUser.access = currentUser.access;
      updatedUser.refresh = currentUser.refresh;

      return await prefs.setString(_userKey, userToJson(updatedUser));
    }

    return false;
  }

  // Clear user data (logout)
   Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.setBool(_isLoggedInKey, false);
    return await prefs.remove(_userKey);

  }
}