import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:quiz_app/core/database/database_handler_impl.dart';
import 'package:sqflite/sqflite.dart';

import 'core/api/open_trivia_api_handler.dart';
import 'core/api/open_trivia_api_handler_impl.dart';
import 'core/database/database_handler.dart';
import 'core/database/database_init.dart';
import 'core/network/data_connection_checker.dart';
import 'core/network/network_info.dart';
import 'core/network/network_info_impl.dart';
import 'features/quiz/data/datasources/questions_remote_data_source.dart';
import 'features/quiz/data/datasources/questions_remote_data_source_impl.dart';
import 'features/quiz/data/repositories/questions_repository_impl.dart';
import 'features/quiz/domain/repositories/questions_repository.dart';
import 'features/quiz/domain/usecases/get_questions.dart';
import 'features/quiz/presentation/blocs/quiz/quiz_bloc.dart';

final sl = GetIt.instance;

const String openTriviaBaseUrl = 'https://opentdb.com';
const String openTriviaInstanceName = 'OpenTriviaAPI';
const Map<String, String> headers = {
  'Content-Type': 'application/json;charset=UTF-8',
  'Charset': 'utf-8',
};
const Duration timeout = Duration(milliseconds: 20000);

Future<void> init() async {
  // !
  //
  sl.registerLazySingleton<QuestionsRemoteDataSource>(
    () => QuestionsRemoteDataSourceImpl(
      apiHandler: sl(),
    ),
  );
  sl.registerLazySingleton<QuestionsRepository>(
    () => QuestionsRepositoryImpl(
      questionsRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetQuestions(sl()));
  sl.registerFactory(() => QuizBloc(getQuestions: sl()));

  // !Core
  //
  // initialize database
  final database = await DatabaseInit().database as Database;

  // register database
  sl.registerLazySingleton(() => database);

  // register database handler
  sl.registerLazySingleton<DatabaseHandler>(
    () => DatabaseHandlerImpl(
      database: sl(),
    ),
  );

  // initialize OpenTrivia API
  sl.registerLazySingleton<OpenTriviaApiHandler>(
    () => OpenTriviaApiHandlerImpl(
      dio: sl.get(
        instanceName: openTriviaInstanceName,
      ),
    ),
  );

  // initialize data connection checker
  sl.registerLazySingleton(() => DataConnectionChecker());

  // initialize network info
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      dataConnectionChecker: sl(),
    ),
  );

  // !External
  //
  // register dio client for Open Trivia API
  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        connectTimeout: timeout,
        receiveTimeout: timeout,
        baseUrl: openTriviaBaseUrl,
        headers: headers,
        followRedirects: false,
      ),
    ),
    instanceName: openTriviaInstanceName,
  );
}
