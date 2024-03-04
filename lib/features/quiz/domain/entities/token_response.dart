abstract class TokenResponse {
  final int responseCode;
  final String responseMessage;
  final String token;

  TokenResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.token,
  });
}
