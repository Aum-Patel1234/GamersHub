import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:equatable/equatable.dart';
import 'package:gamers_hub/utils/config/config.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
    
    var box = await Hive.openBox(Config.myHiveBox);
    final clientId = dotenv.env['TWITCH_CLIENT_ID']!;
    final bearerToken = box.get('access_token', defaultValue: '');

    _instance = ApiClientIdBearerToken._(clientId: clientId, bearerToken: bearerToken);
    return _instance!;
  }

  @override
  List<Object?> get props => [clientId, bearerToken];
}