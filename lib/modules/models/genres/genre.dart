class Genre {
  final int id;
  final int createdAt; // Consider using DateTime if you need to represent time.
  final String name;
  final String slug;
  final int updatedAt; // Consider using DateTime if you need to represent time.
  final String url;
  final String checksum;

  Genre({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.slug,
    required this.updatedAt,
    required this.url,
    required this.checksum,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      createdAt: json['created_at'],
      name: json['name'],
      slug: json['slug'],
      updatedAt: json['updated_at'],
      url: json['url'],
      checksum: json['checksum'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'name': name,
      'slug': slug,
      'updated_at': updatedAt,
      'url': url,
      'checksum': checksum,
    };
  }
}