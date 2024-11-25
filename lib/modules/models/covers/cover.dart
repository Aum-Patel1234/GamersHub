class Cover {
  final int game;
  final String imageId;
  // final String checksum;

  Cover({
    required this.game,
    required this.imageId,
    // required this.checksum,
  });

  factory Cover.fromJson(Map<String, dynamic> json) {
    return Cover(
      game: json['game'] ?? 0,
      imageId: json['image_id'] ?? '',
      // checksum: json['checksum'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'game': game,
      'image_id': imageId,
    };
  }
}