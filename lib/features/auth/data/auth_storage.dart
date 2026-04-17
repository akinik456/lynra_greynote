import 'dart:convert';
import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  static const _storage = FlutterSecureStorage();
  static const _patternKey = 'app_pattern';
  static const _saltKey = 'secure_salt'; // Yeni anahtarımız
  static const _masterKey = 'master_key'; // Yeni: Veri şifreleme anahtarımız
 
  static Future<void> savePattern(String pattern) async {
    await _storage.write(key: _patternKey, value: pattern);
  }

  static Future<String?> getPattern() async {
    return await _storage.read(key: _patternKey);
  }

  static Future<void> clearPattern() async {
    await _storage.delete(key: _patternKey);
  }
  
/// Hem Salt hem de Master Key'i Onboarding sırasında bir kez üretir.
  static Future<void> initializeSecurity() async {
    final existingSalt = await _storage.read(key: _saltKey);
    final existingMK = await _storage.read(key: _masterKey);
    
    // Eğer üretilmemişlerse üret
    if (existingSalt == null) {
      final salt = base64Encode(List<int>.generate(32, (i) => Random.secure().nextInt(256)));
      await _storage.write(key: _saltKey, value: salt);
    }

    if (existingMK == null) {
      // Her cihaza özel 256-bit rastgele Master Key
      final mk = base64Encode(List<int>.generate(32, (i) => Random.secure().nextInt(256)));
      await _storage.write(key: _masterKey, value: mk);
    }
  }

  /// Master Key'i okur
  static Future<String?> getMasterKey() async {
    return await _storage.read(key: _masterKey);
  }  

/// Saklanan salt değerini (cihaz parmak izini) geri okur.
  static Future<String?> getSecureSalt() async {
    return await _storage.read(key: _saltKey);
  }
  
  
}