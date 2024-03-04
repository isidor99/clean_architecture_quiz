abstract class QuizFailure {}

// returned if http response status code is not 200
class ServerFailure extends QuizFailure {}

// returned if there is not WiFi connection
class WiFiFailure extends QuizFailure {}

// returned if questions list is empty
class PullingQuestionsFailure extends QuizFailure {}

// returned if session token was not pulled successfully
class SessionTokenFailure extends QuizFailure {}
