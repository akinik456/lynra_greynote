import 'dart:convert';
import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  static const _storage = FlutterSecureStorage();
  static const _patternKey = 'app_pattern';
  static const _saltKey = 'secure_salt'; // Yeni anahtarımız
  static const _dbSaltKey = "db_salt";
  static const _masterKey = 'master_key'; // Yeni: Veri şifreleme anahtarımız
  static const _wrappedMasterKey = 'wrapped_master_key'; // Şifrelenmiş paket

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
    final existingDbSalt = await _storage.read(key: _dbSaltKey);
	final existingMK = await _storage.read(key: _masterKey);
    
    // Eğer üretilmemişlerse üret
    if (existingSalt == null) {
      final salt = base64Encode(List<int>.generate(32, (i) => Random.secure().nextInt(256)));
      await _storage.write(key: _saltKey, value: salt);
    }
	
	// 2. DB Salt: Master Key'den SQLCipher şifresi türetmek için
    if (existingDbSalt == null) {
      final dbSalt = base64Encode(List<int>.generate(32, (i) => Random.secure().nextInt(256)));
      await _storage.write(key: _dbSaltKey, value: dbSalt);
    }

    if (existingMK == null) {
      // Her cihaza özel 256-bit rastgele Master Key
      final mk = base64Encode(List<int>.generate(32, (i) => Random.secure().nextInt(256)));
      await _storage.write(key: _masterKey, value: mk);
    }
  }

/// Saklanan salt değerini (cihaz parmak izini) geri okur.
  static Future<String?> getSecureSalt() async {
    return await _storage.read(key: _saltKey);
  }
/// Ham Master Key'i okur (Sadece paketleme işlemi için kullanılır)
  static Future<String?> getRawMasterKey() async {
    return await _storage.read(key: _masterKey);
  }

  /// Paketlenmiş (Şifrelenmiş) Master Key'i saklar
  static Future<void> saveWrappedMasterKey(String wrappedMK) async {
    await _storage.write(key: _wrappedMasterKey, value: wrappedMK);
  }

  /// Paketlenmiş Master Key'i okur (Uygulama içinde asıl kullanılacak olan budur)
  static Future<String?> getWrappedMasterKey() async {
    return await _storage.read(key: _wrappedMasterKey);
  }  
  
/// Ham Master Key'i diskten tamamen siler.
  /// Bu işlem, MK başarıyla paketlendikten (Wrap) sonra güvenlik için zorunludur.
  static Future<void> deleteRawMasterKey() async {
    await _storage.delete(key: _masterKey);
  }  
  
}