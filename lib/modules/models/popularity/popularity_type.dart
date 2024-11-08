class PopularitySource {
  final int id;
  final int popularitySource;
  final String name;
  final int createdAt;
  final int updatedAt;
  final String checksum;

  PopularitySource({
    required this.id,
    required this.popularitySource,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.checksum,
  });

  // Factory constructor to create a PopularitySource object from JSON
  factory PopularitySource.fromJson(Map<String, dynamic> json) {
    return PopularitySource(
      id: json['id'] ?? 0,
      popularitySource: json['popularity_source'] ?? 0,
      name: json['name'] ?? '',
      createdAt: json['created_at'] ?? 0,
      updatedAt: json['updated_at'] ?? 0,
      checksum: json['checksum'] ?? '',
    );
  }

  // Method to convert a PopularitySource object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'popularity_source': popularitySource,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'checksum': checksum,
    };
  }
}