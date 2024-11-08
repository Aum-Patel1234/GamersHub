import 'dart:convert';
import 'dart:developer';

import 'package:gamers_hub/modules/models/covers/cover.dart';
import 'package:gamers_hub/modules/models/games/games.dart';
import 'package:gamers_hub/modules/models/popularity/popularity_primitive.dart';
import 'package:gamers_hub/modules/service/api_client_id_bearer_token.dart';
import 'package:gamers_hub/modules/ui/shared/show_snack_bar.dart';
import 'package:http/http.dart';

class HomePageApiService {
  final Client _client = Client();

  Future<List<PopularityPrimitive>?> _getPopularityPrimitive({required int offset,required int limit}) async {
    try{
      final ApiClientIdBearerToken instance = await ApiClientIdBearerToken.getInstance();
      final Uri uri = Uri.parse('https://api.igdb.com/v4/popularity_primitives');

      final Response response = await _client.post(
        uri,
        headers: {
          'Client-ID': instance.clientId,
          'Authorization': 'Bearer ${instance.bearerToken}',
          'Content-Type': 'application/json',
        },
        body: 'fields *;  sort value desc;  limit $limit;   offset $offset;',
      );
      // log(response.body);

      if(response.statusCode == 200){
        final List<dynamic> parsedData = jsonDecode(response.body);

        List<PopularityPrimitive> popularityPrimitives = parsedData.map((element) => PopularityPrimitive.fromJson(element)).toList();

        return popularityPrimitives;
      }
      
      handleApiResponse(json.decode(response.body));        // to show the custom snackbar
    }catch (e){
      log(e.toString());
    }
    
    return null;    
  }

  Future<List<Games>?> getTopChartsGames({required int offset,required int limit}) async{
    List<PopularityPrimitive>? popularGames = await _getPopularityPrimitive(limit: limit,offset: offset);

    if(popularGames == null){
      return null;
    }
    log(popularGames.length.toString());

    final ApiClientIdBearerToken instance = await ApiClientIdBearerToken.getInstance();
    final Uri uri = Uri.parse('https://api.igdb.com/v4/games');

    final List<int> gameIds = popularGames.map((element) => element.gameId).toList();
    final gameIdsString = '(${gameIds.join(',')})';
    final Response response = await _client.post(
      uri,
      headers: {
        'Client-ID': instance.clientId,
        'Authorization': 'Bearer ${instance.bearerToken}',
        'Content-Type': 'application/json',
      },
      body: 'fields *;  where id = $gameIdsString;',               // offset 15;
    );
    // fields *; where id = (8,9,11);

    if(response.statusCode != 200){
      log(response.body);
      handleApiResponse(jsonDecode(response.body));              // to show the custom snackbar
      return null;
    }

    // final List<dynamic> parsedData = jsonDecode(response.body);
    final List<dynamic> parsedData = jsonDecode(response.body);
    return parsedData.map((game) => Games.fromJson(game)).toList();
  }

  Future<List<Cover>?> getCovers({required List<Games> games}) async{                     // i need games to take covers
    final ApiClientIdBearerToken instance = await ApiClientIdBearerToken.getInstance();
    final Uri uri = Uri.parse('https://api.igdb.com/v4/covers');

    final List<int> gameIds = games.map((game) => game.id).toList();
    final gameIdsString = '(${gameIds.join(',')})';

    final Response response = await _client.post(
      uri,
      headers: {
        'Client-ID': instance.clientId,
        'Authorization': 'Bearer ${instance.bearerToken}',
        'Content-Type': 'application/json',
      },
      body: 'fields *;  where id = $gameIdsString;',
    );

    if(response.statusCode != 200){ 
      handleApiResponse(jsonDecode(response.body));          // to show the custom snackbar
      return null;
    }

    final List<dynamic> parsedData = jsonDecode(response.body);
    return parsedData.map((game) => Cover.fromJson(game)).toList();
  }
}
