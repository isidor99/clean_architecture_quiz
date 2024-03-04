import 'package:dartz/dartz.dart';
import 'package:quiz_app/core/error/quiz_failure.dart';

abstract class QuestionsRepository {
  Future<Either<QuizFailure, Map<String, dynamic>>> getQuestions({
    String? token,
    required int amount,
  });
}
