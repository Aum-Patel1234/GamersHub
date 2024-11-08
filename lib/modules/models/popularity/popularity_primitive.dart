class PopularityPrimitive {
  final int id;
  final int gameId;
  final double value;
  final int createdAt;

  PopularityPrimitive({
    required this.id,
    required this.gameId,
    required this.value,
    required this.createdAt,
  });

  // Factory constructor to create a PopularityPrimitive object from JSON
  factory PopularityPrimitive.fromJson(Map<String, dynamic> json) {
    return PopularityPrimitive(
      id: json['id'] ?? 0,
      gameId: json['game_id'] as int,
      value: json['value'] as double,
      createdAt: json['created_at'] as int,
    ); 
  }

  // Method to convert a PopularityPrimitive object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'game_id': gameId,
      'value': value,
      'created_at': createdAt,
    };
  }
}