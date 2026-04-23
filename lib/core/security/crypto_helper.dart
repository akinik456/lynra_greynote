import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';
import 'package:cryptography/cryptography.dart';
import '../../features/auth/data/auth_storage.dart';

class CryptoHelper {
  static final _algorithm = AesGcm.with256bits();

/// Master Key'i (MK) başka bir anahtar ile paketler (şifreler).
  /// [keyToWrap]: Cihazdaki ham Master Key
  /// [password]: Kullanıcının Pattern/PIN stringi
  /// [vaultWord]: Varsa Vault Word, yoksa ""
  static Future<String> wrapMasterKey({
    required String mkBase64,
    required String password,
  }) async {
    // 1. Paketleme anahtarını türet (Pass + Salt)
    // Not: Buradaki şifreleme için mevcut deriveKey fonksiyonumuzu kullanıyoruz
    final wrappingKey = await deriveKey(password );

    // 2. Master Key'i bu yeni anahtarla şifrele
    final mkBytes = base64Decode(mkBase64);
    final secretBox = await _algorithm.encrypt(
      mkBytes,
      secretKey: wrappingKey,
    );

    // 3. Şifrelenmiş paketi geri döndür
    return base64Encode(secretBox.concatenation());
  }

  /// Paketlenmiş Master Key'i çözer.
  static Future<String> unwrapMasterKey({
    required String wrappedMKBase64,
    required String password,
  }) async {
  // 1. Anahtar Türetme: deriveKey içeride AuthStorage.getSecureSalt()
    // çağırarak cihazın özel tuzunu zaten karışıma ekliyor.
    final wrappingKey = await deriveKey(password);
    final concatenation = base64Decode(wrappedMKBase64);
    // 2. Paketin parçalarına (nonce, mac, ciphertext) ayrılması
	final secretBox = SecretBox.fromConcatenation(
      concatenation,
      nonceLength: _algorithm.nonceLength,
      macLength: _algorithm.macAlgorithm.macLength,
    );

    final decryptedBytes = await _algorithm.decrypt(
      secretBox,
      secretKey: wrappingKey,
    );
	// 4. Ham Master Key'i (MK) geri döndürür.
    return base64Encode(decryptedBytes);
  }
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
    iterations: 10000, // 100k iterasyon brute-force'u yavaşlatır
    bits: 256,
  );

  return await pbkdf2.deriveKey(
    secretKey: SecretKey(utf8.encode(password)),
    nonce: saltBytes,
  );
}
static Future<String> deriveDbKey(String masterKey) async {
  final saltBase64 = await AuthStorage.getDbSalt();

  if (saltBase64 == null) {
    throw Exception("Security Error: DB Salt not initialized!");
  }

  final saltBytes = base64Decode(saltBase64);

  final pbkdf2 = Pbkdf2(
    macAlgorithm: Hmac.sha256(),
    iterations: 10000,
    bits: 256,
  );

  final secretKey = await pbkdf2.deriveKey(
    secretKey: SecretKey(utf8.encode(masterKey)),
    nonce: saltBytes,
  );

  final keyBytes = await secretKey.extractBytes();
  return base64Encode(keyBytes);
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
static Future<SecretKey> deriveBackupKey({
  required String pattern,
  required String exportPin,
  required String saltBase64,
}) async {
  final saltBytes = base64Decode(saltBase64);

  final pbkdf2 = Pbkdf2(
    macAlgorithm: Hmac.sha256(),
    iterations: 10000,
    bits: 256,
  );

  return await pbkdf2.deriveKey(
    secretKey: SecretKey(utf8.encode('$pattern|$exportPin')),
    nonce: saltBytes,
  );
}

static Future<Map<String, dynamic>> encryptBackupBlob({
  required String plainJson,
  required String pattern,
  required String exportPin,
}) async {
  final backupSalt = base64Encode(
    List<int>.generate(32, (_) => Random.secure().nextInt(256)),
  );

  final key = await deriveBackupKey(
    pattern: pattern,
    exportPin: exportPin,
    saltBase64: backupSalt,
  );

  final nonce = _algorithm.newNonce();

  final secretBox = await _algorithm.encrypt(
    utf8.encode(plainJson),
    secretKey: key,
    nonce: nonce,
  );

  return {
    'type': 'lynra_backup',
    'version': 1,
    'kdf': 'pbkdf2-sha256',
    'iterations': 10000,
    'salt': backupSalt,
    'blob': base64Encode(secretBox.concatenation()),
  };
}  

static Future<String> decryptBackupBlob({
  required Map<String, dynamic> backupJson,
  required String pattern,
  required String exportPin,
}) async {
  final saltBase64 = (backupJson['salt'] ?? '').toString();
  final blobBase64 = (backupJson['blob'] ?? '').toString();

  if (saltBase64.isEmpty || blobBase64.isEmpty) {
    throw Exception('Invalid backup file');
  }

  final key = await deriveBackupKey(
    pattern: pattern,
    exportPin: exportPin,
    saltBase64: saltBase64,
  );

  final concatenation = base64Decode(blobBase64);

  final secretBox = SecretBox.fromConcatenation(
    concatenation,
    nonceLength: _algorithm.nonceLength,
    macLength: _algorithm.macAlgorithm.macLength,
  );

  final decryptedBytes = await _algorithm.decrypt(
    secretBox,
    secretKey: key,
  );

  return utf8.decode(decryptedBytes);
}
static Future<String> encryptWithKey(
  String plainText,
  SecretKey key,
) async {
  final nonce = _algorithm.newNonce();

  final secretBox = await _algorithm.encrypt(
    utf8.encode(plainText),
    secretKey: key,
    nonce: nonce,
  );

  final combined = <int>[
    ...nonce,
    ...secretBox.cipherText,
    ...secretBox.mac.bytes,
  ];

  return base64Encode(combined);
}

static Future<String> decryptWithKey(
  String encrypted,
  SecretKey key,
) async {
  final combined = base64Decode(encrypted);

  final nonce = combined.sublist(0, 12);
  final mac = Mac(combined.sublist(combined.length - 16));
  final cipherText = combined.sublist(12, combined.length - 16);

  final secretBox = SecretBox(cipherText, nonce: nonce, mac: mac);

  final decrypted = await _algorithm.decrypt(
    secretBox,
    secretKey: key,
  );

  return utf8.decode(decrypted);
}

static Future<SecretKey> derivePayloadKey(String masterKey) async {
  return SecretKey(base64Decode(masterKey));
}  
}