import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  static const _storage = FlutterSecureStorage();

  static const _patternKey = 'app_pattern';
  static const _saltKey = 'secure_salt';
  static const _dbSaltKey = 'db_salt';
  static const _masterKey = 'master_key';
  static const _wrappedMasterKey = 'wrapped_master_key';

  static Future<String?> safeRead(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      debugPrint('SECURE STORAGE READ FAILED: $key -> $e');
      await _storage.deleteAll();
      return null;
    }
  }

  static Future<void> safeWrite({
    required String key,
    required String value,
  }) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      debugPrint('SECURE STORAGE WRITE FAILED: $key -> $e');
      await _storage.deleteAll();
      rethrow;
    }
  }

  static Future<void> safeDelete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      debugPrint('SECURE STORAGE DELETE FAILED: $key -> $e');
      await _storage.deleteAll();
    }
  }

  static String _randomBase64(int length) {
    return base64Encode(
      List<int>.generate(
        length,
        (_) => Random.secure().nextInt(256),
      ),
    );
  }

  static Future<void> savePattern(String pattern) async {
    await safeWrite(key: _patternKey, value: pattern);
  }

  static Future<String?> getPattern() async {
    return safeRead(_patternKey);
  }

  static Future<void> clearPattern() async {
    await safeDelete(_patternKey);
  }

  static Future<void> initializeSecurity() async {
    final existingSalt = await safeRead(_saltKey);
    final existingDbSalt = await safeRead(_dbSaltKey);
    final existingMK = await safeRead(_masterKey);

    if (existingSalt == null) {
      await safeWrite(
        key: _saltKey,
        value: _randomBase64(32),
      );
    }

    if (existingDbSalt == null) {
      await safeWrite(
        key: _dbSaltKey,
        value: _randomBase64(32),
      );
    }

    if (existingMK == null) {
      await safeWrite(
        key: _masterKey,
        value: _randomBase64(32),
      );
    }
  }

  static Future<String?> getSecureSalt() async {
    return safeRead(_saltKey);
  }

  static Future<String?> getRawMasterKey() async {
    return safeRead(_masterKey);
  }

  static Future<String?> getDbSalt() async {
    return safeRead(_dbSaltKey);
  }

  static Future<void> saveWrappedMasterKey(String wrappedMK) async {
    await safeWrite(key: _wrappedMasterKey, value: wrappedMK);
  }

  static Future<String?> getWrappedMasterKey() async {
    return safeRead(_wrappedMasterKey);
  }

  static Future<void> deleteRawMasterKey() async {
    await safeDelete(_masterKey);
  }

  static Future<void> resetSecureStorage() async {
    await _storage.deleteAll();
  }
}