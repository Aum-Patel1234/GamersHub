class EventLogo {
  // final int id;
  final int event;
  final String imageId;

  EventLogo({
    // required this.id,
    required this.event,
    required this.imageId,
  });

  factory EventLogo.fromJson(Map<String, dynamic> json) {
    return EventLogo(
      // id: json['id'] ?? 0,
      event: json['event'] ?? 0,
      imageId: json['image_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'event': event,
      'image_id': imageId,
    };
  }
}