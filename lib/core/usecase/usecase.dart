import 'package:dartz/dartz.dart';
import 'package:quiz_app/core/error/quiz_failure.dart';

abstract class UseCase<Type, Params> {
  const UseCase();

  Future<Either<QuizFailure, Type>> call(Params params);
}
