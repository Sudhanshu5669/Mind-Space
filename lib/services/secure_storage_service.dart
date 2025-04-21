import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = FlutterSecureStorage();
  
  // Token operations
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }
  
  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }
  
  Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
  }
  
  // User ID operations
  Future<void> saveUserId(String userId) async {
    await _storage.write(key: 'user_id', value: userId);
  }
  
  Future<String?> getUserId() async {
    return await _storage.read(key: 'user_id');
  }
  
  // Check login status
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
  
  // Clear all data (for logout)
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}