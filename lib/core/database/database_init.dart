import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class TableNames {
  static const tTakenQuiz = 'taken_quiz';
  static const tQuizType = 'quiz_type';
  static const tQuiz = 'quiz';
}

class DatabaseInit {
  static const _dbName = 'quiz.db';
  static const _dbVersion = 1;

  Database? _database;

  Future<Database?> get database async {
    // return database if it is not null
    if (_database != null) return _database;

    // create a new one in case the database does not exist
    _database = await _createDatabase();

    //
    return _database;
  }

  Future<Database> _createDatabase() async {
    // get directory
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // join directory path with database name
    String dbPath = join(documentsDirectory.path, _dbName);

    // open new database
    var database = await openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );

    //
    return database;
  }

  // this function is used for inserting values in quiz_type table
  String _insertIntoQuizTypeTable(
    String name,
    int numberOfQuestions,
    String description,
  ) {
    return "INSERT INTO quiz_type (name, number_of_questions, description) "
        "VALUES ('$name', $numberOfQuestions, '$description')";
  }

  void _onCreate(Database database, int version) async {
    // create quiz_type table
    const String tQuizTypeQuery = 'CREATE TABLE ${TableNames.tQuizType} ('
        'id INT, '
        'name TEXT NOT NULL,'
        'number_of_questions INT NOT NULL, '
        'description TEXT NOT NULL, '
        'PRIMARY KEY (id)'
        ')';

    // create quiz table
    const String tQuizQuery = 'CREATE TABLE ${TableNames.tQuiz} ('
        'id INT, '
        'name TEXT NOT NULL, '
        'description TEXT NOT NULL, '
        'quiz_type_id INT NOT NULL, '
        'PRIMARY KEY (id), '
        'FOREIGN KEY (quiz_type_id) '
        'REFERENCES quiz_type(id)'
        ')';

    // create quiz_stats table
    const String tQuizStatsQuery = 'CREATE TABLE ${TableNames.tTakenQuiz} ('
        'id INT, '
        'quiz_datetime DATETIME NOT NULL, '
        'total_time TIME NOT NULL, '
        'correct_answers INT NOT NULL, '
        'quiz_id INT NOT NULL, '
        'PRIMARY KEY (id), '
        'FOREIGN KEY (quiz_id) '
        'REFERENCES quiz(id)'
        ')';

    // quiz_type insert query
    String tQuizTypeInsertQuery =
        '${_insertIntoQuizTypeTable('Standard', 10, 'Quiz with 10 questions of different categories and different difficulty levels')};'
        '${_insertIntoQuizTypeTable('Extended', 15, 'Quiz with 15 questions of different categories and different difficulty levels')};';

    // quiz insert query

    Batch batch = database.batch();
    batch.execute(tQuizTypeQuery);
    batch.execute(tQuizQuery);
    batch.execute(tQuizStatsQuery);
    batch.execute(tQuizTypeInsertQuery);

    await batch.commit(noResult: true);
  }

  void _onUpgrade(Database database, int oldVersion, int newVersion) {
    // this code is executed when database version is updated
    if (oldVersion == _dbVersion - 1 && newVersion == _dbVersion) {}
  }
}
