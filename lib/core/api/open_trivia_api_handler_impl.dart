import 'package:dio/dio.dart';

import 'open_trivia_api_handler.dart';

class OpenTriviaApiHandlerImpl implements OpenTriviaApiHandler {
  final Dio dio;

  OpenTriviaApiHandlerImpl({required this.dio});

  @override
  Future<Response> getSessionToken() async =>
      await dio.get('/api_token.php?command=request');

  @override
  Future<Response> getQuestions({
    required String token,
    required int amount,
  }) async =>
      await dio.get('/api.php?amount=$amount&token=$token');
}
