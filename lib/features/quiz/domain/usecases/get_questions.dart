import 'package:dartz/dartz.dart';
import 'package:quiz_app/core/error/quiz_failure.dart';
import 'package:quiz_app/core/usecase/params.dart';
import 'package:quiz_app/core/usecase/usecase.dart';

import '../repositories/questions_repository.dart';

class GetQuestions extends UseCase<Map<String, dynamic>, Params> {
  final QuestionsRepository questionsRepository;

  GetQuestions(this.questionsRepository);

  @override
  Future<Either<QuizFailure, Map<String, dynamic>>> call(Params params) async =>
      await questionsRepository.getQuestions(
        token: params.params[Params.keyToken],
        amount: params.params[Params.keyAmount],
      );
}
