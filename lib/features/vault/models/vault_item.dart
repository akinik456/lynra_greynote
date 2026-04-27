import 'dart:convert';

class VaultItem {
  final String id;
  final String collectionId;
  final String title;
  final String username;
  final String password;
  final String note;
  final String iban;
  final String pattern;
  final int createdAt;
  final int updatedAt;
  final int lastChangedAt;
  final bool isFavorite;
  final String type;
  final bool hasAttachment; //  eklendi (AMA JSON’a dahil değil)
	
  VaultItem({
    required this.id,
    required this.title,
    required this.username,
    required this.password,
    required this.note,
    required this.iban,
 		required this.pattern,
    required this.createdAt,
    required this.updatedAt,
    required this.lastChangedAt,
    required this.isFavorite,
    required this.collectionId,
    required this.type,
    this.hasAttachment = false,
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
        "type": type,
				"pattern": pattern,
        //  hasAttachment YOK (bilerek)
      };

  factory VaultItem.fromJson(Map<String, dynamic> json) {
    return VaultItem(
      id: json["id"],
      title: json["title"] ?? "",
      username: json["username"] ?? "",
      password: json["password"] ?? "",
      note: json["note"] ?? "",
      iban: json["iban"] ?? "",
			pattern: json["pattern"] ?? "",
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      lastChangedAt: json["lastChangedAt"],
      isFavorite: json["isFavorite"] ?? false,
      collectionId: json["collectionId"] ?? "default",
      type: json["type"] ?? "standard",
      // hasAttachment DB’den set edilecek
    );
  }

  String toEncodedJson() => jsonEncode(toJson());

  static VaultItem fromEncodedJson(String encoded) {
    final Map<String, dynamic> map = jsonDecode(encoded);
    return VaultItem.fromJson(map);
  }

  //  önemli (repository kullanıyor)
  VaultItem copyWith({
    String? id,
    String? title,
    String? username,
    String? password,
    String? note,
    String? iban,
		String? pattern,
    int? createdAt,
    int? updatedAt,
    int? lastChangedAt,
    bool? isFavorite,
    String? collectionId,
    String? type,
    bool? hasAttachment,
  }) {
    return VaultItem(
      id: id ?? this.id,
      title: title ?? this.title,
      username: username ?? this.username,
      password: password ?? this.password,
      note: note ?? this.note,
      iban: iban ?? this.iban,
			pattern: pattern ?? this.pattern,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastChangedAt: lastChangedAt ?? this.lastChangedAt,
      isFavorite: isFavorite ?? this.isFavorite,
      collectionId: collectionId ?? this.collectionId,
      type: type ?? this.type,
      hasAttachment: hasAttachment ?? this.hasAttachment,
    );
  }
}