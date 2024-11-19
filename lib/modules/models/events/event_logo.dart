class EventLogo {
  // final int id;
  final int event;
  final String url;

  EventLogo({
    // required this.id,
    required this.event,
    required this.url,
  });

  factory EventLogo.fromJson(Map<String, dynamic> json) {
    return EventLogo(
      // id: json['id'] ?? 0,
      event: json['event'] ?? 0,
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'event': event,
      'url': url,
    };
  }
}