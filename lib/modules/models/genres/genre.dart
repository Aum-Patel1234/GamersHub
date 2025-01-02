class Genre {
  // final int id;
  // final int createdAt; 
  final String name;
  final String slug;
  // final int updatedAt;
  // final String url;
  // final String checksum;

  Genre({
    required this.name,
    required this.slug,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      name: json['name'] as String,
      slug: json['slug'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'slug': slug,
    };
  }
}