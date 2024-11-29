class ScreenShot {
  final int id;
  // final bool alphaChannel;
  // final bool animated;
  final int game;
  // final int height;
  final String imageId;
  // final String url;
  // final int width;
  // final String checksum;

  // Constructor
  ScreenShot({
    required this.id,
    required this.game,
    required this.imageId,
  });

  // Factory constructor to create a ScreenShot from JSON
  factory ScreenShot.fromJson(Map<String, dynamic> json) {
    return ScreenShot(
      id: json['id'] as int,
      game: json['game'] as int,
      imageId: json['image_id'] as String,
    );
  }

  // Method to convert a ScreenShot instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'game': game,
      'image_id': imageId,
    };
  }
}
