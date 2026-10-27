import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await storage.write(key: "accessToken", value: token);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: "accessToken");
  }

  static Future<void> removeToken() async {
    await storage.delete(key: "accessToken");
  }
}