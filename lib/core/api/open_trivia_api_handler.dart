import 'package:dio/dio.dart';

abstract class OpenTriviaApiHandler {
  Future<Response> getSessionToken();

  Future<Response> getQuestions({required String token, required int amount});
}
