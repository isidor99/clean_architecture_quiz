import 'dart:io';

import 'package:dio/dio.dart';
import 'package:quiz_app/core/api/open_trivia_api_handler.dart';
import 'package:quiz_app/core/error/exception.dart';

import '../models/question_response_model.dart';
import '../models/token_response_model.dart';
import 'questions_remote_data_source.dart';

class QuestionsRemoteDataSourceImpl extends QuestionsRemoteDataSource {
  final OpenTriviaApiHandler apiHandler;

  QuestionsRemoteDataSourceImpl({required this.apiHandler});

  // TODO: register all in injection container
  @override
  Future<TokenResponseModel> qetSessionToken() async {
    // get response from api
    Response response = await apiHandler.getSessionToken();

    if (response.statusCode == HttpStatus.ok) {
      return TokenResponseModel.fromJsonUrl(response.data);
    } else {
      throw OpenTriviaServerException();
    }
  }

  @override
  Future<QuestionResponseModel> getQuestions({
    required String token,
    required int amount,
  }) async {
    // get response from api
    Response response = await apiHandler.getQuestions(
      token: token,
      amount: amount,
    );

    // check status code and return data or throw an exception
    if (response.statusCode == HttpStatus.ok) {
      return QuestionResponseModel.fromJsonUrl(response.data);
    } else {
      throw OpenTriviaServerException();
    }
  }
}
