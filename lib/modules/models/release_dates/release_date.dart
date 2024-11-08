class ReleaseDate {
  final int id;
  final int category;
  final int createdAt;
  final String date; 
  final int game;
  final String human;
  final int m; 
  final int platform;
  final int region;
  final int updatedAt; 
  final int y; 
  final String checksum;

  ReleaseDate({
    required this.id,
    required this.category,
    required this.createdAt,
    required this.date,
    required this.game,
    required this.human,
    required this.m,
    required this.platform,
    required this.region,
    required this.updatedAt,
    required this.y,
    required this.checksum,
  });

  // Optionally, you can add methods to convert from/to JSON
  factory ReleaseDate.fromJson(Map<String, dynamic> json) {
    return ReleaseDate(
      id: json['id'],
      category: json['category'],
      createdAt: json['created_at'],
      date: json['date'],
      game: json['game'],
      human: json['human'],
      m: json['m'],
      platform: json['platform'],
      region: json['region'],
      updatedAt: json['updated_at'],
      y: json['y'],
      checksum: json['checksum'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'created_at': createdAt,
      'date': date,
      'game': game,
      'human': human,
      'm': m,
      'platform': platform,
      'region': region,
      'updated_at': updatedAt,
      'y': y,
      'checksum': checksum,
    };
  }
}