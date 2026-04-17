import 'dart:convert';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import '../../features/auth/data/auth_storage.dart';

class CryptoHelper {
  static final _algorithm = AesGcm.with256bits();

  static Future<SecretKey> deriveKey(String password) async {
  // Cihaza özel güvenli tuzu (salt) AuthStorage'dan çek
  final saltBase64 = await AuthStorage.getSecureSalt();
  
  if (saltBase64 == null) {
    // Eğer salt yoksa (hata durumu), güvenliği korumak için işlemi durdur
    throw Exception("Security Error: Secure Salt not initialized!");
  }

  final saltBytes = base64Decode(saltBase64);

  final pbkdf2 = Pbkdf2(
    macAlgorithm: Hmac.sha256(),
    iterations: 100000, // 100k iterasyon brute-force'u yavaşlatır
    bits: 256,
  );

  return await pbkdf2.deriveKey(
    secretKey: SecretKey(utf8.encode(password)),
    nonce: saltBytes,
  );
}

  static Future<String> encrypt(String plainText, String password) async {
    final key = await deriveKey(password);

    final nonce = _algorithm.newNonce();
    final secretBox = await _algorithm.encrypt(
      utf8.encode(plainText),
      secretKey: key,
      nonce: nonce,
    );

    final combined = <int>[
      ...nonce,
      ...secretBox.cipherText,
      ...secretBox.mac.bytes
    ];

    return base64Encode(combined);
  }

  static Future<String> decrypt(String encrypted, String password) async {
    final key = await deriveKey(password);

    final combined = base64Decode(encrypted);

    final nonce = combined.sublist(0, 12);
    final mac = Mac(combined.sublist(combined.length - 16));
    final cipherText =
        combined.sublist(12, combined.length - 16);

    final secretBox = SecretBox(cipherText, nonce: nonce, mac: mac);

    final decrypted = await _algorithm.decrypt(
      secretBox,
      secretKey: key,
    );

    return utf8.decode(decrypted);
  }
}