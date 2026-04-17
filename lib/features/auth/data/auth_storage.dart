import 'dart:convert';
import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  static const _storage = FlutterSecureStorage();
  static const _patternKey = 'app_pattern';
  static const _saltKey = 'secure_salt'; // Yeni anahtarımız

  static Future<void> savePattern(String pattern) async {
    await _storage.write(key: _patternKey, value: pattern);
  }

  static Future<String?> getPattern() async {
    return await _storage.read(key: _patternKey);
  }

  static Future<void> clearPattern() async {
    await _storage.delete(key: _patternKey);
  }
  
  /// Cihaza özel 256-bit benzersiz salt üretir ve güvenli saklar.
  static Future<void> initializeSecureSalt() async {
    // Eğer daha önce üretilmişse tekrar üretme (mevcut şifrelemeler bozulmasın)
    final existing = await _storage.read(key: _saltKey);
    if (existing != null) return;

    // Kriptografik olarak güvenli rastgele 32 byte üret
    final random = Random.secure();
    final values = List<int>.generate(32, (i) => random.nextInt(256));
    final saltBase64 = base64Encode(values);
}
/// Saklanan salt değerini (cihaz parmak izini) geri okur.
  static Future<String?> getSecureSalt() async {
    return await _storage.read(key: _saltKey);
  }
}