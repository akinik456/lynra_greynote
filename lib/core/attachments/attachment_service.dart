import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:cryptography/cryptography.dart';
import '../../../core/security/crypto_helper.dart';

class AttachmentService {
  static const String _folderName = 'attachments';
  static const int maxAttachmentBytes = 2 * 1024 * 1024;
	
	bool isValidAttachmentSize(int byteLength) {
  return byteLength > 0 && byteLength <= maxAttachmentBytes;
	}
	
		String buildAttachmentPayload({
		required String type,
		required Uint8List bytes,
	}) {
		final base64Data = base64Encode(bytes);

		final payload = {
			"type": type,
			"data": base64Data,
		};

		return jsonEncode(payload);
	}
	
	String? detectAttachmentType(String? extension) {
  final ext = extension?.toLowerCase();

  if (ext == 'pdf') return 'pdf';

  if (ext == 'jpg' || ext == 'jpeg' || ext == 'png') {
    return 'image';
  }

  return null;
}
	
  Future<Directory> getAttachmentsDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final attachmentsDir = Directory('${appDir.path}/$_folderName');

    if (!await attachmentsDir.exists()) {
      await attachmentsDir.create(recursive: true);
    }

    return attachmentsDir;
  }
	Future<String> getAttachmentPath(String itemId) async {
  final dir = await getAttachmentsDirectory();
  return '${dir.path}/$itemId.enc';
	}
	Future<void> writeRawAttachment({
		required String itemId,
		required Uint8List bytes,
	}) async {
		final path = await getAttachmentPath(itemId);
		final file = File(path);

		await file.writeAsBytes(bytes, flush: true);
	}	
	
	Future<Uint8List?> readRawAttachment(String itemId) async {
		final path = await getAttachmentPath(itemId);
		final file = File(path);

		if (!await file.exists()) return null;

		return await file.readAsBytes();
	}
	
	Future<bool> attachmentExists(String itemId) async {
		final path = await getAttachmentPath(itemId);
		return File(path).exists();
	}

	Future<void> deleteAttachment(String itemId) async {
		final path = await getAttachmentPath(itemId);
		final file = File(path);

		if (await file.exists()) {
			await file.delete();
		}
	}	
	
	Future<String> encryptAttachmentPayload({
		required String payload,
		required SecretKey key,
	}) async {
		return await CryptoHelper.encryptWithKey(payload, key);
	}
	
	Future<void> saveEncryptedAttachment({
		required String itemId,
		required String type,
		required Uint8List bytes,
		required SecretKey key,
	}) async {
		if (!isValidAttachmentSize(bytes.length)) {
			throw Exception('Attachment is too large');
		}

		final payload = buildAttachmentPayload(
			type: type,
			bytes: bytes,
		);

		final encrypted = await encryptAttachmentPayload(
			payload: payload,
			key: key,
		);

		final path = await getAttachmentPath(itemId);
		final file = File(path);

		await file.writeAsString(encrypted, flush: true);
	}
	
	Future<Map<String, dynamic>?> readEncryptedAttachment({
		required String itemId,
		required SecretKey key,
	}) async {
		final path = await getAttachmentPath(itemId);
		final file = File(path);

		if (!await file.exists()) return null;

		final encrypted = await file.readAsString();

		final decrypted = await CryptoHelper.decryptWithKey(
			encrypted,
			key,
		);

		final Map<String, dynamic> json = jsonDecode(decrypted);

		return json;
	}
	
	
}