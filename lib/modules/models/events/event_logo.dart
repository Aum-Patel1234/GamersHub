class EventLogo {
  // final int id;
  final int event;
  final int height;
  final String imageId;
  final String url;
  final int width;
  final String checksum;

  EventLogo({
    // required this.id,
    required this.event,
    required this.height,
    required this.imageId,
    required this.url,
    required this.width,
    required this.checksum,
  });

  factory EventLogo.fromJson(Map<String, dynamic> json) {
    return EventLogo(
      // id: json['id'] ?? 0,
      event: json['event'] ?? 0,
      height: json['height'] ?? 0,
      imageId: json['image_id'] ?? '',
      url: json['url'] ?? '',
      width: json['width'] ?? 0,
      checksum: json['checksum'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'event': event,
      'height': height,
      'image_id': imageId,
      'url': url,
      'width': width,
      'checksum': checksum,
    };
  }
}