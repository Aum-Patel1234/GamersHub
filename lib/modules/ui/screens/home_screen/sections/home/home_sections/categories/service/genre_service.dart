import 'dart:convert';

import 'package:gamers_hub/modules/models/genres/genre.dart';
import 'package:gamers_hub/modules/service/api_client_id_bearer_token.dart';
import 'package:gamers_hub/modules/ui/shared/show_snack_bar.dart';
import 'package:http/http.dart';

class GenreService {
  final _client = Client();

  Future<List<Genre>?> getGenres() async{
    final ApiClientIdBearerToken instance = await ApiClientIdBearerToken.getInstance();
    final Uri uri = Uri.parse('https://api.igdb.com/v4/genres');

    const String fields = 'name,slug';

    final Response response = await _client.post(
      uri,
      headers: {
        'Client-ID': instance.clientId,
        'Authorization': 'Bearer ${instance.bearerToken}',
        'Content-Type': 'application/json',
      },
      body: 'fields $fields;  limit  100',               
    );
    // fields *; limit *;

    if(response.statusCode != 200){
      // log(response.body);
      handleApiResponse(jsonDecode(response.body));              // to show the custom snackbar
      return null;
    }

    final List<dynamic> parsedData = jsonDecode(response.body);
    return parsedData.map((genre) => Genre.fromJson(genre)).toList();
  }
}