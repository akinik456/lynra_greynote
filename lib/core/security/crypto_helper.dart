import 'dart:convert';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';

class CryptoHelper {
  static final _algorithm = AesGcm.with256bits();

  static Future<SecretKey> deriveKey(String password) async {
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: 100000,
      bits: 256,
    );

    final salt = utf8.encode("lynra_salt");

    return await pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(password)),
      nonce: salt,
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