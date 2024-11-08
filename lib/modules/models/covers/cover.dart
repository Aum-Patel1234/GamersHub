class Cover {
  final int id;
  // final bool alphaChannel;
  // final bool animated;
  // final int game;
  // final String gameLocalization;
  final int height;
  // final String imageId;
  final String url;
  final int width;
  final String checksum;

  Cover({
    required this.id,
    required this.height,
    required this.url,
    required this.width,
    required this.checksum,
  });

  factory Cover.fromJson(Map<String, dynamic> json) {
    return Cover(
      id: json['id'],
      height: json['height'],
      url: json['url'],
      width: json['width'],
      checksum: json['checksum'],
    );
  }
}