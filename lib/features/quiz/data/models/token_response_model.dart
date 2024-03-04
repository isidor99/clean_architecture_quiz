import '../../domain/entities/token_response.dart';

class TokenResponseModel extends TokenResponse {
  TokenResponseModel({
    required super.responseCode,
    required super.responseMessage,
    required super.token,
  });

  factory TokenResponseModel.fromJsonUrl(Map<String, dynamic> json) {
    return TokenResponseModel(
      responseCode: json['response_code'],
      responseMessage: json['response_message'],
      token: json['token'],
    );
  }
}
