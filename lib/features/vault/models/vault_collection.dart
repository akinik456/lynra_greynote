class VaultCollection {
  final String id;
  final String name;
  final int createdAt;
  final int updatedAt;

  VaultCollection({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VaultCollection.fromMap(Map<String, dynamic> map) {
    return VaultCollection(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      createdAt: map['createdAt'] ?? 0,
      updatedAt: map['updatedAt'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}