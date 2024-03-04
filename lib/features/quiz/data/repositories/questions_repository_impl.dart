import 'package:dartz/dartz.dart';
import 'package:quiz_app/core/error/exception.dart';
import 'package:quiz_app/core/error/quiz_failure.dart';
import 'package:quiz_app/core/network/network_info.dart';

import '../../domain/repositories/questions_repository.dart';
import '../datasources/questions_remote_data_source.dart';

class QuestionsRepositoryImpl implements QuestionsRepository {
  final QuestionsRemoteDataSource questionsRemoteDataSource;
  final NetworkInfo networkInfo;

  QuestionsRepositoryImpl({
    required this.questionsRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<QuizFailure, Map<String, dynamic>>> getQuestions({
    String? token,
    required int amount,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        if (token == null) {
          // get session token
          final result = await questionsRemoteDataSource.qetSessionToken();

          // check token response code
          if (result.responseCode == 0) {
            // set token to be equal to retrieved token
            token = result.token;
          } else {
            // return error
            return Left(SessionTokenFailure());
          }
        }

        // get questions from OpenTrivia API
        final result = await questionsRemoteDataSource.getQuestions(
          token: token,
          amount: amount,
        );

        // check questions result
        if (result.responseCode == 0 && result.questions.isNotEmpty) {
          // return questions
          return Right({
            'token': token,
            'questions': result.questions,
          });
        }

        // questions list is empty, return failure
        return Left(PullingQuestionsFailure());
      } on OpenTriviaServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(WiFiFailure());
    }
  }
}
