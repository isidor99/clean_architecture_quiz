import 'package:sqflite/sqflite.dart';

import 'database_handler.dart';

class DatabaseHandlerImpl implements DatabaseHandler {
  final Database database;

  DatabaseHandlerImpl({required this.database});
}
