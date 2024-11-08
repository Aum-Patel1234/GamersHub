import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';

class ApiClientIdBearerToken extends Equatable {
  final String clientId;
  final String bearerToken;

  const ApiClientIdBearerToken._({required this.clientId, required this.bearerToken});

  // Singleton instance
  static ApiClientIdBearerToken? _instance;

  static Future<ApiClientIdBearerToken> getInstance() async {
    if (_instance != null) {
      return _instance!;
    }
    
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final clientId = dotenv.env['TWITCH_CLIENT_ID']!;
    final bearerToken = prefs.getString("access_token") ?? '';

    _instance = ApiClientIdBearerToken._(clientId: clientId, bearerToken: bearerToken);
    return _instance!;
  }

  @override
  List<Object?> get props => [clientId, bearerToken];
}