import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    const storage =  FlutterSecureStorage();
    // Write value
    await storage.write(key: CacheManagerKey.token.toString(), value: token);
    return true;
  }

  Future<String?> getToken() async {
    // Create storage
    const storage =  FlutterSecureStorage();

// Read value
    String? value = await storage.read(key: CacheManagerKey.token.toString());
    Logger().e("Token is: $value");
    return value;
  }

  Future<void> removeToken() async {
    // Create storage
    const storage =  FlutterSecureStorage();
// Delete value
    await storage.delete(key: CacheManagerKey.token.toString());
  }

  Future<void> saveOTP(String otp) async
  {
  const storage =  FlutterSecureStorage();
    // Write value
    await storage.write(key: CacheManagerKey.otp.toString(), value: otp);
   
 }
 Future<String?> getOTP() async {
    // Create storage
    const storage =  FlutterSecureStorage();

// Read value
    String? value = await storage.read(key: CacheManagerKey.otp.toString());
    Logger().e("OTP is: $value");
    return value;
  }
}

enum CacheManagerKey { token,otp }
