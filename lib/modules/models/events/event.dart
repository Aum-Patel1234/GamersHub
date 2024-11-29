class Event {
  final int id;
  final String name;
  final String description;
  final String slug;
  final int eventLogo;
  final int startTime;
  final int endTime;
  final String timeZone;
  final String liveStreamUrl;
  final List<int> games;
  final List<int> videos;
  final List<int> eventNetworks;
  final int createdAt;
  final int updatedAt;
  // final String checksum;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.slug,
    required this.eventLogo,
    required this.startTime,
    required this.endTime,
    required this.timeZone,
    required this.liveStreamUrl,
    required this.games,
    required this.videos,
    required this.eventNetworks,
    required this.createdAt,
    required this.updatedAt,
    // required this.checksum,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      slug: json['slug'] ?? '',
      eventLogo: json['event_logo'] ?? 0,
      startTime: json['start_time'] ?? 0,
      endTime: json['end_time'] ?? 0,
      timeZone: json['time_zone'] ?? '',
      liveStreamUrl: json['live_stream_url'] ?? '',
      games: List<int>.from(json['games'] ?? []),
      videos: List<int>.from(json['videos'] ?? []),
      eventNetworks: List<int>.from(json['event_networks'] ?? []),
      createdAt: json['created_at'] ?? 0,
      updatedAt: json['updated_at'] ?? 0,
      // checksum: json['checksum'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'slug': slug,
      'event_logo': eventLogo,
      'start_time': startTime,
      'end_time': endTime,
      'time_zone': timeZone,
      'live_stream_url': liveStreamUrl,
      'games': games,
      'videos': videos,
      'event_networks': eventNetworks,
      'created_at': createdAt,
      'updated_at': updatedAt,
      // 'checksum': checksum,
    };
  }
}