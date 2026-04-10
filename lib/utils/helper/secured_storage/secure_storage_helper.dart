import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  // Singleton instance (one throughout app)
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  /// Save value
  static Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Read value
  static Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// Delete value
  static Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// Clear all storage
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}