import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  static const _storage = FlutterSecureStorage();
  static const _patternKey = 'app_pattern';

  static Future<void> savePattern(String pattern) async {
    await _storage.write(key: _patternKey, value: pattern);
  }

  static Future<String?> getPattern() async {
    return await _storage.read(key: _patternKey);
  }

  static Future<void> clearPattern() async {
    await _storage.delete(key: _patternKey);
  }
}