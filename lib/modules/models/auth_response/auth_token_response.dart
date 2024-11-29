class AuthTokenResponse {
  final String accessToken;
  final int expiresIn; // Duration for which the token is valid
  final String tokenType;

  AuthTokenResponse({
    required this.accessToken,
    required this.expiresIn,
    required this.tokenType,
  });

  factory AuthTokenResponse.fromJson(Map<String, dynamic> json) {
    return AuthTokenResponse(
      accessToken: json['access_token'],
      expiresIn: json['expires_in'] as int,
      tokenType: json['token_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'expires_in': expiresIn,
      'token_type': tokenType,
    };
  }
}
