import 'dart:convert';
import 'dart:developer';

import 'package:gamers_hub/modules/models/genres/genre.dart';
import 'package:gamers_hub/modules/service/api_client_id_bearer_token.dart';
import 'package:gamers_hub/modules/ui/shared/show_snack_bar.dart';
import 'package:http/http.dart';

class GenreService {
  final _client = Client();

  Future<List<Genre>?> getGenres() async {
    try {
      final ApiClientIdBearerToken instance = await ApiClientIdBearerToken.getInstance();
      final Uri uri = Uri.parse('https://api.igdb.com/v4/genres');

      const String fields = 'slug';
      final response = await _client.post(
        uri,
        headers: {
          'Client-ID': instance.clientId,
          'Authorization': 'Bearer ${instance.bearerToken}',
          'Content-Type': 'application/json',
        },
        body: 'fields $fields; limit 100;', 
      );

      if (response.statusCode != 200) {
        // Handle API response error (could be a failure response)
        handleApiResponse(jsonDecode(response.body));
        return null;
      }

      final List<dynamic> parsedData = jsonDecode(response.body);
      return parsedData.map((genre) => Genre.fromJson(genre)).toList();
    } catch (e, stackTrace) {
      log('Error fetching genres: $e', stackTrace: stackTrace);
      // showSnackBar('Failed to fetch genres. Please try again later.');
      return null;
    }
  }
}
