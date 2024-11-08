class Theme {
  final int id;
  final String name;
  final String slug;
  final int updatedAt; // Consider using DateTime if you need to represent time.
  final String url;
  final String checksum;

  Theme({
    required this.id,
    required this.name,
    required this.slug,
    required this.updatedAt,
    required this.url,
    required this.checksum,
  });

  factory Theme.fromJson(Map<String, dynamic> json) {
    return Theme(
      id: json['id'],
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
      'name': name,
      'slug': slug,
      'updated_at': updatedAt,
      'url': url,
      'checksum': checksum,
    };
  }
}