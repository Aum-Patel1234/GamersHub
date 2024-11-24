// checksum is a key that helps to tell that there is no tampering of data if the key i have and the server gives is same
class Games {
  final int id;
  // final List<int>? ageRatings;
  // final double? aggregatedRating;
  // final int? aggregatedRatingCount;
  // final List<int>? alternativeNames;
  final List<int>? artworks;
  final List<int>? bundles;
  final int? category;
  // final List<int>? collections;
  final int? cover;
  final int? createdAt;
  final List<int>? dlcs;
  // final List<int>? expandedGames;
  // final List<int>? expansions;
  final List<int>? externalGames;
  final int? firstReleaseDate;
  // final List<dynamic>? forks;
  // final int? franchise;
  final List<int>? franchises;
  final List<int>? gameEngines;
  // final List<int>? gameLocalizations;
  final List<int>? gameModes;
  final List<int>? genres;
  final int? hypes;
  final List<int>? involvedCompanies;
  // final List<int>? keywords;
  // final List<int>? languageSupports;
  // final List<int>? multiplayerModes;
  final String? name;
  // final int? parentGame;
  // final List<int>? platforms;
  // final List<int>? playerPerspectives;
  // final List<int>? ports;
  // final double? rating;
  // final int? ratingCount;
  // final List<int>? releaseDates;
  // final List<int>? remakes;
  // final List<int>? remasters;
  final List<int>? screenshots;
  final List<int>? similarGames;
  final String? slug;
  // final List<int>? standaloneExpansions;
  final int? status;
  final String? storyline;
  final String? summary;
  // final List<int>? tags;
  final List<int>? themes;
  final double? totalRating;
  final int? totalRatingCount;
  final int? updatedAt;
  final String? url;
  // final List<String>? versionParent;
  // final String? versionTitle;
  final List<int>? videos;
  final List<int>? websites;

  Games({
    required this.id,
    this.artworks,
    this.bundles,
    this.category,
    // this.collections,
    this.cover,
    this.createdAt,
    this.dlcs,
    this.externalGames,
    this.firstReleaseDate,
    this.franchises,
    this.gameEngines,
    // this.gameLocalizations,
    this.gameModes,
    this.genres,
    this.hypes,
    this.involvedCompanies,
    this.name,
    this.screenshots,
    this.similarGames,
    this.slug,
    this.status,
    this.storyline,
    this.summary,
    this.themes,
    this.totalRating,
    this.totalRatingCount,
    this.updatedAt,
    this.url,
    this.videos,
    this.websites,
  });

  factory Games.fromJson(Map<String, dynamic> json) {
    return Games(
      id: json['id'],
      artworks: List<int>.from(json['artworks'] ?? []),
      bundles: List<int>.from(json['bundles'] ?? []),
      category: json['category'],
      // collections: List<int>.from(json['collections'] ?? []),
      cover: json['cover'],
      createdAt: json['created_at'],
      dlcs: List<int>.from(json['dlcs'] ?? []),
      firstReleaseDate: json['first_release_date'],
      franchises: List<int>.from(json['franchises'] ?? []),
      gameEngines: List<int>.from(json['game_engines'] ?? []),
      // gameLocalizations: List<int>.from(json['game_localizations'] ?? []),
      gameModes: List<int>.from(json['game_modes'] ?? []),
      genres: List<int>.from(json['genres'] ?? []),
      hypes: json['hypes'],
      involvedCompanies: List<int>.from(json['involved_companies'] ?? []),
      name: json['name'],
      screenshots: List<int>.from(json['screenshots'] ?? []),
      similarGames: List<int>.from(json['similar_games'] ?? []),
      slug: json['slug'],
      status: json['status'],
      storyline: json['storyline'],
      summary: json['summary'],
      themes: List<int>.from(json['themes'] ?? []),
      totalRating: json['total_rating']?.toDouble(),
      totalRatingCount: json['total_rating_count'],
      updatedAt: json['updated_at'],
      url: json['url'],
      websites: List<int>.from(json['websites'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'artworks': artworks,
      'bundles': bundles,
      'category': category,
      'cover': cover,
      'created_at': createdAt,
      'dlcs': dlcs,
      'external_games': externalGames,
      'first_release_date': firstReleaseDate,
      'franchises': franchises,
      'game_engines': gameEngines,
      'game_modes': gameModes,
      'genres': genres,
      'hypes': hypes,
      'involved_companies': involvedCompanies,
      'name': name,
      'screenshots': screenshots,
      'similar_games': similarGames,
      'slug': slug,
      'status': status,
      'storyline': storyline,
      'summary': summary,
      'themes': themes,
      'total_rating': totalRating,
      'total_rating_count': totalRatingCount,
      'updated_at': updatedAt,
      'url': url,
      'videos': videos,
      'websites': websites,
    };
  }
}