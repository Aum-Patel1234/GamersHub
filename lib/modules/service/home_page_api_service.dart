import 'dart:convert';
import 'dart:developer';

import 'package:gamers_hub/modules/models/events/event.dart';
import 'package:gamers_hub/modules/models/events/event_logo.dart';
import 'package:gamers_hub/modules/models/events/event_network.dart';
import 'package:gamers_hub/modules/models/popularity/popularity_primitive.dart';
import 'package:gamers_hub/modules/service/api_client_id_bearer_token.dart';
import 'package:gamers_hub/modules/ui/shared/show_snack_bar.dart';
import 'package:http/http.dart';

class HomePageApiService {
  final Client _client = Client();

  Future<List<int>?> getPopularityPrimitive({required int offset,required int limit}) async {
    try{
      final ApiClientIdBearerToken instance = await ApiClientIdBearerToken.getInstance();
      final Uri uri = Uri.parse('https://api.igdb.com/v4/popularity_primitives');

      const String fields = 'id,game_id,value';

      final Response response = await _client.post(
        uri,
        headers: {
          'Client-ID': instance.clientId,
          'Authorization': 'Bearer ${instance.bearerToken}',
          'Content-Type': 'application/json',
        },
        body: 'fields $fields;  sort value desc;  limit $limit;   offset $offset;',
      );
      // log(response.body);

      if(response.statusCode == 200){
        final List<dynamic> parsedData = jsonDecode(response.body);

        List<PopularityPrimitive> popularityPrimitives = parsedData.map((element) => PopularityPrimitive.fromJson(element)).toList();

        return popularityPrimitives.map((pp) => pp.gameId).toList();
      }
      
      handleApiResponse(json.decode(response.body));        // to show the custom snackbar
    }catch (e){
      log(e.toString());
    }
    
    return null;    
  }

  // Future<List<Games>?> getTopChartsGames({required int offset,required int limit}) async{
  //   List<PopularityPrimitive>? popularGames = await _getPopularityPrimitive(limit: limit,offset: offset);

  //   if(popularGames == null){
  //     return null;
  //   }

  //   final ApiClientIdBearerToken instance = await ApiClientIdBearerToken.getInstance();
  //   final Uri uri = Uri.parse('https://api.igdb.com/v4/games');

  //   final List<int> gameIds = popularGames.map((element) => element.gameId).toList();
  //   final gameIdsString = '(${gameIds.join(',')})';
  //   final Response response = await _client.post(
  //     uri,
  //     headers: {
  //       'Client-ID': instance.clientId,
  //       'Authorization': 'Bearer ${instance.bearerToken}',
  //       'Content-Type': 'application/json',
  //     },
  //     body: 'fields *;  where id = $gameIdsString;',               // offset 15;
  //   );
  //   // fields *; where id = (8,9,11);

  //   if(response.statusCode != 200){
  //     log(response.body);
  //     handleApiResponse(jsonDecode(response.body));              // to show the custom snackbar
  //     return null;
  //   }

  //   // final List<dynamic> parsedData = jsonDecode(response.body);
  //   final List<dynamic> parsedData = jsonDecode(response.body);
  //   return parsedData.map((game) => Games.fromJson(game)).toList();
  // }

  // Future<List<Cover>?> getCovers({List<Games>? games,List<int>? gameId,required String parameter}) async{                     // i need games to take covers
  //   final ApiClientIdBearerToken instance = await ApiClientIdBearerToken.getInstance();
  //   final Uri uri = Uri.parse('https://api.igdb.com/v4/covers');

  //   if(games == null && gameId == null)  return null; 
  //   final List<int> gameIds = games == null ? gameId! : games.map((game) => game.id).toList();
  //   final gameIdsString = '(${gameIds.join(',')})';

  //   final Response response = await _client.post(
  //     uri,
  //     headers: {
  //       'Client-ID': instance.clientId,
  //       'Authorization': 'Bearer ${instance.bearerToken}',
  //       'Content-Type': 'application/json',
  //     },
  //     body: 'fields game,url;  where $parameter = $gameIdsString;',  // id for games covers and game for events bottomsheet
  //   );

  //   if(response.statusCode != 200){ 
  //     handleApiResponse(jsonDecode(response.body));          // to show the custom snackbar
  //     return null;
  //   }

  //   final List<dynamic> parsedData = jsonDecode(response.body);
  //   return parsedData.map((game) => Cover.fromJson(game)).toList();
  // }

  Future<List<Event>?> getEvents({required int limit,required int offset})async{
    /*
      sort the events with respect to start_time
      we can get event_logo by getting the event_logo parameter in event and post req with id = event_logo
      we also have event_network endpoint where we can get the link of the resp game twitter,facebook or youtube links 
    */
    final ApiClientIdBearerToken instance = await ApiClientIdBearerToken.getInstance();
    final Uri uri = Uri.parse('https://api.igdb.com/v4/events');

    try{
      final Response response = await _client.post(
        uri,
        headers: {
          'Client-ID': instance.clientId,
          'Authorization': 'Bearer ${instance.bearerToken}',
          'Content-Type': 'application/json',
        },
        body: 'fields *;  where start_time > ${DateTime.now().millisecondsSinceEpoch}; limit $limit;  offset $offset;',     // upcoming events
      );

      if(response.statusCode != 200){
        handleApiResponse(jsonDecode(response.body));
        return null;
      }

      final List<dynamic> parsedData = jsonDecode(response.body);
      return parsedData.map((event) => Event.fromJson(event)).toList();
    }catch(e){
      log(e.toString());
    }
    
    return null;
  }
  
  Future<List<EventLogo>?> getEventLogos({required List<Event> events})async{
    final ApiClientIdBearerToken instance = await ApiClientIdBearerToken.getInstance();
    final Uri uri = Uri.parse('https://api.igdb.com/v4/event_logos');

    final List<int> eventLogos = events.map((event) => event.eventLogo).toList();
    final String eventIDs = '(${eventLogos.where((logo) => logo != 0).join(',')})';               // when there is no event_logo attribute we get value 0 so dont add it or else null
    const String fields = 'event,image_id';

    try{
      final Response response = await _client.post(
        uri,
        headers: {
          'Client-ID': instance.clientId,
          'Authorization': 'Bearer ${instance.bearerToken}',
          'Content-Type': 'application/json',
        },
        body: 'fields $fields;  where id = $eventIDs;',     // upcoming events
      );

      if(response.statusCode != 200){
        handleApiResponse(jsonDecode(response.body));
        return null;
      }

      final List<dynamic> parsedData = jsonDecode(response.body);
      return parsedData.map((eventLogo) => EventLogo.fromJson(eventLogo)).toList();
    }catch(e){
      log(e.toString());
    }
    
    return null;
  }

  Future<List<EventNetwork>?> getEventNewtworks({required List<Event> events})async{
    final ApiClientIdBearerToken instance = await ApiClientIdBearerToken.getInstance();
    final Uri uri = Uri.parse('https://api.igdb.com/v4/event_networks');

    final List<int> eventNetworks = [];

    for (Event event in events) {
      eventNetworks.addAll(event.eventNetworks);
    }

    final String eventIDs = '(${eventNetworks.join(',')})';

    try{
      final Response response = await _client.post(
        uri,
        headers: {
          'Client-ID': instance.clientId,
          'Authorization': 'Bearer ${instance.bearerToken}',
          'Content-Type': 'application/json',
        },
        body: 'fields *;  where id = $eventIDs',     // upcoming events
      );

      if(response.statusCode != 200){
        handleApiResponse(jsonDecode(response.body));
        return null;
      }

      final List<dynamic> parsedData = jsonDecode(response.body);
      return parsedData.map((eventNetwork) => EventNetwork.fromJson(eventNetwork)).toList();
    }catch(e){
      log(e.toString());
    }
    
    return null;
  }
}
