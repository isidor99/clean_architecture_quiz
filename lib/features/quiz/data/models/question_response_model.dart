import '../../domain/entities/question.dart';
import '../../domain/entities/question_response.dart';

class QuestionResponseModel extends QuestionResponse {
  QuestionResponseModel({
    required super.responseCode,
    required super.questions,
  });

  factory QuestionResponseModel.fromJsonUrl(Map<String, dynamic> json) {
    // get response code
    int responseCode = json['response_code'];

    // check response code
    if (responseCode == 0) {
      return QuestionResponseModel(
        responseCode: json['response_code'],
        questions: Question.fromJsonArray(json['results']),
      );
    }

    // return empty questions list if response code is not correct
    return QuestionResponseModel(responseCode: responseCode, questions: []);
  }
}
