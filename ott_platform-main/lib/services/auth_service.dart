import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthServices {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> saveUserToken(String userToken) async {
    // For Now we are using flutter_secure_storage to store user token
    // Todo: store user details, user types and based on that navigate to screen
    await _secureStorage.write(key: 'user_token', value: userToken);
  }

  Future<String?> getUserToken() async {
    return await _secureStorage.read(key: 'user_token');
  }
}
