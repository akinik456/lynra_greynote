import 'dart:convert';

class VaultItem {
  final String id;
  final String collectionId;
  final String title;
  final String username;
  final String password;
  final String note;
  final String iban;
  final int createdAt;
  final int updatedAt;
  final int lastChangedAt;
  final bool isFavorite;
  
  VaultItem({
    required this.id,
    required this.title,
    required this.username,
    required this.password,
    required this.note,
 	required this.iban,
    required this.createdAt,
    required this.updatedAt,
    required this.lastChangedAt,
    required this.isFavorite,
	required this.collectionId,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "username": username,
        "password": password,
        "note": note,
		"iban": iban,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "lastChangedAt": lastChangedAt,
        "isFavorite": isFavorite,
		"collectionId": collectionId,
      };

  factory VaultItem.fromJson(Map<String, dynamic> json) {
    return VaultItem(
      id: json["id"],
      title: json["title"] ?? "",
      username: json["username"] ?? "",
      password: json["password"] ?? "",
      note: json["note"] ?? "",
	  iban: json["iban"] ?? "",
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      lastChangedAt: json["lastChangedAt"],
      isFavorite: json["isFavorite"] ?? false,
	  collectionId: json["collectionId"] ?? "default",
    );
  }

  String toEncodedJson() => jsonEncode(toJson());

  static VaultItem fromEncodedJson(String encoded) {
    final Map<String, dynamic> map = jsonDecode(encoded);
    return VaultItem.fromJson(map);
  }
}