import 'dart:convert';
import 'dart:developer';

import 'package:gamers_hub/modules/models/artworks/artwork.dart';
import 'package:gamers_hub/modules/models/games/game_video.dart';
import 'package:gamers_hub/modules/models/screenshots/screenshot.dart';
import 'package:http/http.dart';
import 'package:gamers_hub/modules/service/api_client_id_bearer_token.dart';

class GameScreenService {
  final Client _client = Client();

  void getGames(){
    // get games
  }

  Future<List<String>?> getYouTubeVideos({required List<int> videoIds}) async{
    final ApiClientIdBearerToken instance = await ApiClientIdBearerToken.getInstance();
    final Uri uri = Uri.parse('https://api.igdb.com/v4/game_videos');
    final String videoIdsString = '(${videoIds.join(',')})';

    try{
      final Response response = await _client.post(
        uri,
        headers: {
          'Client-ID': instance.clientId,
          'Authorization': 'Bearer ${instance.bearerToken}',
          'Content-Type': 'application/json',
        },
        body: 'fields id,game,video_id; where id = $videoIdsString;',      // fields id,game,video_id
      );

      final List<GameVideo> gameVideos = (jsonDecode(response.body) as List<dynamic>).map((video) => GameVideo.fromJson(video)).toList();
      final List<String> vidoeLinks = [];

      // https://www.youtube.com/watch?v=$videoId
      for(GameVideo gameVideo in gameVideos){
        vidoeLinks.add('https://www.youtube.com/watch?v=${gameVideo.videoId}');
      }

      return vidoeLinks;
    }catch (e){
      log(e.toString());
      return null;
    }
  }

   Future<List<String>?> getGameScreenShots({required List<int> getGameScreenShots}) async{
    final ApiClientIdBearerToken instance = await ApiClientIdBearerToken.getInstance();
    final Uri uri = Uri.parse('https://api.igdb.com/v4/screenshots');
    final String getGameScreenShotsString = '(${getGameScreenShots.join(',')})';

    try{
      final Response response = await _client.post(
        uri,
        headers: {
          'Client-ID': instance.clientId,
          'Authorization': 'Bearer ${instance.bearerToken}',
          'Content-Type': 'application/json',
        },
        body: 'fields id,game,image_id; where id = $getGameScreenShotsString;',      // fields id,game,video_id
      );

      final List<ScreenShot> gameScreenShots = (jsonDecode(response.body) as List<dynamic>).map((screenShot) => ScreenShot.fromJson(screenShot)).toList();
      final List<String> screenshots = [];

    // https://images.igdb.com/igdb/image/upload/t_1080p/co670h.jpg
      for(ScreenShot gameScreenShot in gameScreenShots){
        screenshots.add('https://images.igdb.com/igdb/image/upload/t_1080p/${gameScreenShot.imageId}.jpg');
      }

      return screenshots;
    }catch (e){
      log(e.toString());
      return null;
    }
  }

  Future<List<String>?> getGameArtworks({required List<int> artworks}) async{
    final ApiClientIdBearerToken instance = await ApiClientIdBearerToken.getInstance();
    final Uri uri = Uri.parse('https://api.igdb.com/v4/artworks');
    final String getGameArtworksString = '(${artworks.join(',')})';

    try{
      final Response response = await _client.post(
        uri,
        headers: {
          'Client-ID': instance.clientId,
          'Authorization': 'Bearer ${instance.bearerToken}',
          'Content-Type': 'application/json',
        },
        body: 'fields id,game,image_id; where id = $getGameArtworksString;',      // fields id,game,video_id
      );

      final List<Artwork> getGameArtworks = (jsonDecode(response.body) as List<dynamic>).map((artwork) => Artwork.fromJson(artwork)).toList();
      final List<String> gameArtworks = [];

    // https://images.igdb.com/igdb/image/upload/t_1080p/co670h.jpg
      for(Artwork artwork in getGameArtworks){
        gameArtworks.add('https://images.igdb.com/igdb/image/upload/t_1080p/${artwork.imageId}.jpg');
      }

      return gameArtworks;
    }catch (e){
      log(e.toString());
      return null;
    }
  }

  void getGameCovers(){
    // https://api.igdb.com/v4/covers
  }
  
  void getGameEngines(){
    // https://api.igdb.com/v4/game_engines
  }
  void getGameModes(){
    // https://api.igdb.com/v4/game_modes
    // we can use hive library
  }

  void getGenres(){
    // https://api.igdb.com/v4/genres
    // we can use hive library and can create a single service file for endpoints - games,genres,covers,
  }
  
  void getCategories(){
    // https://api-docs.igdb.com/#game-enums use hive
    // main_game	0
    // dlc_addon	1
    // expansion	2
    // bundle	3
    // standalone_expansion	4
    // mod	5
    // episode	6
    // season	7
    // remake	8
    // remaster	9
    // expanded_game	10
    // port	11
    // fork	12
    // pack	13
    // update	14
  }

  void getInvolvedCompanies(){

  }


}