import 'dart:convert';
import 'dart:developer';

import 'package:gamers_hub/modules/models/covers/cover.dart';
import 'package:gamers_hub/modules/models/games/games.dart';
import 'package:gamers_hub/modules/models/genres/genre.dart';
import 'package:gamers_hub/modules/service/api_client_id_bearer_token.dart';
import 'package:gamers_hub/modules/ui/shared/show_snack_bar.dart';
import 'package:http/http.dart';

class CommonService {
  final Client _client = Client();

  Future<List<Games>?> getGames({required List<int> gameIds})async{
    final ApiClientIdBearerToken instance = await ApiClientIdBearerToken.getInstance();
    final Uri uri = Uri.parse('https://api.igdb.com/v4/games');

    final gameIdsString = '(${gameIds.join(',')})';
    const String fields = 'artworks,bundles,category,cover,created_at,dlcs,external_games,first_release_date,franchises,game_engines,game_modes,genres,hypes,involved_companies,name,screenshots,similar_games,slug,status,storyline,summary,themes,total_rating,total_rating_count,updated_at,url,videos,websites';

    final Response response = await _client.post(
      uri,
      headers: {
        'Client-ID': instance.clientId,
        'Authorization': 'Bearer ${instance.bearerToken}',
        'Content-Type': 'application/json',
      },
      body: 'fields $fields;  where id = $gameIdsString;',               // offset 15;
    );
    // fields *; where id = (8,9,11);

    if(response.statusCode != 200){
      log(response.body);
      handleApiResponse(jsonDecode(response.body));              // to show the custom snackbar
      return null;
    }

    final List<dynamic> parsedData = jsonDecode(response.body);
    return parsedData.map((game) => Games.fromJson(game)).toList();
  }

  Future<List<Cover>?> getCovers({required List<int> coverIds,required String parameter})async{
    final ApiClientIdBearerToken instance = await ApiClientIdBearerToken.getInstance();
    final Uri uri = Uri.parse('https://api.igdb.com/v4/covers');

    final gameIdsString = '(${coverIds.join(',')})';
    const String fields = 'game,image_id';

    final Response response = await _client.post(
      uri,
      headers: {
        'Client-ID': instance.clientId,
        'Authorization': 'Bearer ${instance.bearerToken}',
        'Content-Type': 'application/json',
      },
      body: 'fields $fields;  where $parameter = $gameIdsString;',  // id for games covers and game for events bottomsheet
    );

    if(response.statusCode != 200){ 
      handleApiResponse(jsonDecode(response.body));          // to show the custom snackbar
      return null;
    }

    final List<dynamic> parsedData = jsonDecode(response.body);
    // https://images.igdb.com/igdb/image/upload/t_1080p/co670h.jpg
    return parsedData.map((game) => Cover.fromJson(game)).toList();
  }


  Future<List<Genre>?> getGenres()async{
    // use hive package 

    return null;
  }
  Future<List<String>?> getCategories({required List<int> categoryEnum})async{
    // use hive package 

    return null;
  }
}