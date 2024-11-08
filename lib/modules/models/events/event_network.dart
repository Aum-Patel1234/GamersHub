class EventNetwork {
  final int id;
  final int event;
  final String url;
  final int networkType;
  // final String checksum;
  
  // below are the network types
// "id": 1,
// "name": "Twitch",

// "id": 2,
// "name": "Official website",
    
// "id": 4,
// "name": "Twitter",

// "id": 3,
// "name": "YouTube",

  EventNetwork({
    required this.id,
    required this.event,
    required this.url,
    required this.networkType,
    // required this.checksum,
  });

  // Factory constructor for creating a new EventNetwork instance from a map
  factory EventNetwork.fromJson(Map<String, dynamic> json) {
    return EventNetwork(
      id: json['id'] as int,
      event: json['event'] as int,
      url: json['url'] as String,
      networkType: json['network_type'] as int,
      // checksum: json['checksum'] as String,
    );
  }

  // Method to convert an EventNetwork instance to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event': event,
      'url': url,
      'network_type': networkType,
      // 'checksum': checksum,
    };
  }
}