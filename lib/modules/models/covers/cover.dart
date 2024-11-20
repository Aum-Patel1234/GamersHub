class Cover {
  final int game;
  final String url;
  // final String checksum;

  Cover({
    required this.game,
    required this.url,
    // required this.checksum,
  });

  factory Cover.fromJson(Map<String, dynamic> json) {
    return Cover(
      game: json['game'] ?? 0,
      url: json['url'] ?? '',
      // checksum: json['checksum'],
    );
  }
}