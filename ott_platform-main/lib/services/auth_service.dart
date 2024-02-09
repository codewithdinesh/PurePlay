import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ott_platform_app/model/UserData.dart';

class AuthServices {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> saveUserToken(String userToken) async {
    // For Now we are using flutter_secure_storage to store user token
    // Todo: store user details, user types and based on that navigate to screen
    await _secureStorage.write(key: 'user_token', value: userToken);
  }

  Future<void> deleteUserToken() async {
    await _secureStorage.delete(key: 'user_token');
  }

  Future<void> saveUser(UserData user) async {
    String userJson = user.toJsonString();
    await _secureStorage.write(key: 'user_data', value: userJson);
  }

  Future<void> deleteUser() async {
    await _secureStorage.delete(key: 'user_data');
  }

  // User is Admin, user or creator
  Future<String?> getUserType() async {
    try {
      final userDataString = await _secureStorage.read(key: 'user_data');
      if (userDataString != null && userDataString.isNotEmpty) {
        final Map<String, dynamic> userDataMap = jsonDecode(userDataString);
        return userDataMap['userType'];
      }
      return null;
    } catch (e) {
      print("Error retrieving user data: $e");
      return null;
    }
  }

  Future<UserData?> getUser() async {
    try {
      final userDataString = await _secureStorage.read(key: 'user_data');
      if (userDataString != null && userDataString.isNotEmpty) {
        final Map<String, dynamic> userDataMap = jsonDecode(userDataString);
        return UserData.fromJson(userDataMap);
      }
      return null;
    } catch (e) {
      print("Error retrieving user data: $e");
      return null;
    }
  }

  Future<String?> getUserToken() async {
    return await _secureStorage.read(key: 'user_token');
  }
}
