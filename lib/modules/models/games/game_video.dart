class GameVideo {
  final int id;
  final int game;
  // final String name;
  final String videoId;
  // final String checksum;

  // Constructor
  GameVideo({
    required this.id,
    required this.game,
    required this.videoId,
  });

  // Factory constructor to create a GameVideo from JSON
  factory GameVideo.fromJson(Map<String, dynamic> json) {
    return GameVideo(
      id: json['id'] as int,
      game: json['game'] as int,
      videoId: json['video_id'] as String,
    );
  }

  // Method to convert a GameVideo instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'game': game,
      'video_id': videoId,
    };
  }
}
