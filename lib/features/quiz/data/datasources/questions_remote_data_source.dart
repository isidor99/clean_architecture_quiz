import '../models/question_response_model.dart';
import '../models/token_response_model.dart';

abstract class QuestionsRemoteDataSource {
  Future<TokenResponseModel> qetSessionToken();

  Future<QuestionResponseModel> getQuestions({
    required String token,
    required int amount,
  });
}
