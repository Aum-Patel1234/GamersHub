import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gamers_hub/modules/models/auth_response/auth_token_response.dart';
import 'package:http/http.dart';

class GameAuthBearerTokenService {
  final Client _client = Client();

  Future<String> getBearerToken() async {
    try {
      final String clientId = dotenv.env['TWITCH_CLIENT_ID']!;
      final String clientSecret = dotenv.env['TWITCH_CLIENT_SECRET']!;
      const String grantType = 'client_credentials';

      final Uri uri = Uri.https('id.twitch.tv', '/oauth2/token', {
        'client_id': clientId,
        'client_secret': clientSecret,
        'grant_type': grantType,
      });

      log(uri.toString());
      final Response response = await _client.post(uri);

      switch (response.statusCode) {
        case 200:
          {
            // Successful response
            final Map<String,dynamic> map = jsonDecode(response.body);
            return AuthTokenResponse.fromJson(map).accessToken;
          }

        case 400:
          {
            // Bad request
            log('Error: Bad Request. Please check your parameters.');
            log('Response Body: ${response.body}');
          }
          break;

        case 401:
          {
            // Unauthorized
            log('Error: Unauthorized. Check your client ID and secret.');
            log('Response Body: ${response.body}');
          }
          break;

        case 403:
          {
            // Forbidden
            log('Error: Forbidden. You do not have access to this resource.');
            log('Response Body: ${response.body}');
          }
          break;

        case 404:
          {
            // Not found
            log('Error: Not Found. The endpoint may be incorrect.');
            log('Response Body: ${response.body}');
          }
          break;

        case 500:
          {
            // Internal server error
            log('Error: Internal Server Error. Please try again later.');
            log('Response Body: ${response.body}');
          }
          break;

        case 503:
          {
            // Service unavailable
            log('Error: Service Unavailable. Please try again later.');
            log('Response Body: ${response.body}');
          }
          break;

        default:
          {
            // Handle any other status codes
            log('Unexpected error: ${response.statusCode}');
            log('Response Body: ${response.body}');
          }
          break;
      }
    } catch (e) {
      log(e.toString());
    }

    return "Bad Response";
  }
}