class Games {
  final int id;
  final List<int>? ageRatings;
  final double? aggregatedRating;
  final int? aggregatedRatingCount;
  final List<int>? alternativeNames;
  final List<int>? artworks;
  final List<int>? bundles;
  final int? category;
  final List<int>? collections;
  final int? cover;
  final int? createdAt;
  final List<int>? dlcs;
  final List<int>? expandedGames;
  final List<int>? expansions;
  final List<int>? externalGames;
  final int? firstReleaseDate;
  final List<dynamic>? forks;
  final int? franchise;
  final List<int>? franchises;
  final List<int>? gameEngines;
  final List<int>? gameLocalizations;
  final List<int>? gameModes;
  final List<int>? genres;
  final int? hypes;
  final List<int>? involvedCompanies;
  final List<int>? keywords;
  final List<int>? languageSupports;
  final List<int>? multiplayerModes;
  final String? name;
  final int? parentGame;
  final List<int>? platforms;
  final List<int>? playerPerspectives;
  final List<int>? ports;
  final double? rating;
  final int? ratingCount;
  final List<int>? releaseDates;
  final List<int>? remakes;
  final List<int>? remasters;
  final List<int>? screenshots;
  final List<int>? similarGames;
  final String? slug;
  final List<int>? standaloneExpansions;
  final int? status;
  final String? storyline;
  final String? summary;
  final List<int>? tags;
  final List<int>? themes;
  final double? totalRating;
  final int? totalRatingCount;
  final int? updatedAt;
  final String? url;
  // final List<String>? versionParent;
  final String? versionTitle;
  final List<int>? videos;
  final List<int>? websites;
  final String? checksum;

  Games({
    required this.id,
    this.ageRatings,
    this.aggregatedRating,
    this.aggregatedRatingCount,
    this.alternativeNames,
    this.artworks,
    this.bundles,
    this.category,
    this.collections,
    this.cover,
    this.createdAt,
    this.dlcs,
    this.expandedGames,
    this.expansions,
    this.externalGames,
    this.firstReleaseDate,
    this.forks,
    this.franchise,
    this.franchises,
    this.gameEngines,
    this.gameLocalizations,
    this.gameModes,
    this.genres,
    this.hypes,
    this.involvedCompanies,
    this.keywords,
    this.languageSupports,
    this.multiplayerModes,
    this.name,
    this.parentGame,
    this.platforms,
    this.playerPerspectives,
    this.ports,
    this.rating,
    this.ratingCount,
    this.releaseDates,
    this.remakes,
    this.remasters,
    this.screenshots,
    this.similarGames,
    this.slug,
    this.standaloneExpansions,
    this.status,
    this.storyline,
    this.summary,
    this.tags,
    this.themes,
    this.totalRating,
    this.totalRatingCount,
    this.updatedAt,
    this.url,
    // this.versionParent,
    this.versionTitle,
    this.videos,
    this.websites,
    this.checksum,
  });

  factory Games.fromJson(Map<String, dynamic> json) {
    return Games(
      id: json['id'],
      ageRatings: List<int>.from(json['age_ratings'] ?? []),
      aggregatedRating: json['aggregated_rating']?.toDouble(),
      aggregatedRatingCount: json['aggregated_rating_count'],
      alternativeNames: List<int>.from(json['alternative_names'] ?? []),
      artworks: List<int>.from(json['artworks'] ?? []),
      bundles: List<int>.from(json['bundles'] ?? []),
      category: json['category'],
      collections: List<int>.from(json['collections'] ?? []),
      cover: json['cover'],
      createdAt: json['created_at'],
      dlcs: List<int>.from(json['dlcs'] ?? []),
      expandedGames: List<int>.from(json['expanded_games'] ?? []),
      expansions: List<int>.from(json['expansions'] ?? []),
      externalGames: List<int>.from(json['external_games'] ?? []),
      firstReleaseDate: json['first_release_date'],
      forks: List<dynamic>.from(json['forks'] ?? []),
      franchise: json['franchise'],
      franchises: List<int>.from(json['franchises'] ?? []),
      gameEngines: List<int>.from(json['game_engines'] ?? []),
      gameLocalizations: List<int>.from(json['game_localizations'] ?? []),
      gameModes: List<int>.from(json['game_modes'] ?? []),
      genres: List<int>.from(json['genres'] ?? []),
      hypes: json['hypes'],
      involvedCompanies: List<int>.from(json['involved_companies'] ?? []),
      keywords: List<int>.from(json['keywords'] ?? []),
      languageSupports: List<int>.from(json['language_supports'] ?? []),
      multiplayerModes: List<int>.from(json['multiplayer_modes'] ?? []),
      name: json['name'],
      parentGame: json['parent_game'],
      platforms: List<int>.from(json['platforms'] ?? []),
      playerPerspectives: List<int>.from(json['player_perspectives'] ?? []),
      ports: List<int>.from(json['ports'] ?? []),
      rating: json['rating']?.toDouble(),
      ratingCount: json['rating_count'],
      releaseDates: List<int>.from(json['release_dates'] ?? []),
      remakes: List<int>.from(json['remakes'] ?? []),
      remasters: List<int>.from(json['remasters'] ?? []),
      screenshots: List<int>.from(json['screenshots'] ?? []),
      similarGames: List<int>.from(json['similar_games'] ?? []),
      slug: json['slug'],
      standaloneExpansions: List<int>.from(json['standalone_expansions'] ?? []),
      status: json['status'],
      storyline: json['storyline'],
      summary: json['summary'],
      tags: List<int>.from(json['tags'] ?? []),
      themes: List<int>.from(json['themes'] ?? []),
      totalRating: json['total_rating']?.toDouble(),
      totalRatingCount: json['total_rating_count'],
      updatedAt: json['updated_at'],
      url: json['url'],
      // versionParent: List<String>.from(json['version_parent'] ?? []),
      versionTitle: json['version_title'],
      videos: List<int>.from(json['videos'] ?? []),
      websites: List<int>.from(json['websites'] ?? []),
      checksum: json['checksum'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'age_ratings': ageRatings,
      'aggregated_rating': aggregatedRating,
      'aggregated_rating_count': aggregatedRatingCount,
      'alternative_names': alternativeNames,
      'artworks': artworks,
      'bundles': bundles,
      'category': category,
      'collections': collections,
      'cover': cover,
      'created_at': createdAt,
      'dlcs': dlcs,
      'expanded_games': expandedGames,
      'expansions': expansions,
      'external_games': externalGames,
      'first_release_date': firstReleaseDate,
      'forks': forks,
      'franchise': franchise,
      'franchises': franchises,
      'game_engines': gameEngines,
      'game_localizations': gameLocalizations,
      'game_modes': gameModes,
      'genres': genres,
      'hypes': hypes,
      'involved_companies': involvedCompanies,
      'keywords': keywords,
      'language_supports': languageSupports,
      'multiplayer_modes': multiplayerModes,
      'name': name,
      'parent_game': parentGame,
      'platforms': platforms,
      'player_perspectives': playerPerspectives,
      'ports': ports,
      'rating': rating,
      'rating_count': ratingCount,
      'release_dates': releaseDates,
      'remakes': remakes,
      'remasters': remasters,
      'screenshots': screenshots,
      'similar_games': similarGames,
      'slug': slug,
      'standalone_expansions': standaloneExpansions,
      'status': status,
      'storyline': storyline,
      'summary': summary,
      'tags': tags,
      'themes': themes,
      'total_rating': totalRating,
      'total_rating_count': totalRatingCount,
      'updated_at': updatedAt,
      'url': url,
      // 'version_parent': versionParent,
      'version_title': versionTitle,
      'videos': videos,
      'websites': websites,
      'checksum': checksum,
    };
  }
}