import 'package:codingjr_todo/models/models.dart';
import 'package:sqflite/sqflite.dart';

// Database service class for managing Todo-related database operations
final class TodoDB {
  // Database constants
  static const _dbName = 'todo.db';
  static const _dbVersion = 1;
  static const _tableName = 'Todo';

  // Column names for the Todo table
  static const _columnId = 'id';
  static const _columnTitle = 'title';
  static const _columnNote = 'note';
  static const _columnIsDone = 'is_done';
  static const _columnCreatedAt = 'created_at';
  static const _columnUpdatedAt = 'updated_at';
  static const _columnCompletedAt = 'completed_at';

  // Instance variable for the SQLite Database
  Database? _db;

  // Initialization method to create or open the database
  Future<Database> init() async {
    // If the database is already initialized, return it
    if (_db != null) return _db!;

    // Constructing the path for the database file
    final dbPath = await getDatabasesPath().then(
      (path) => path + _dbName,
    );

    // Opening or creating the database with the specified parameters
    _db = await openDatabase(
      dbPath,
      onCreate: _onCreate,
      version: _dbVersion,
    );

    // Returning the initialized database
    return _db!;
  }

  // Method called during database creation to define the table schema
  Future<void> _onCreate(Database db, int version) => db.execute('''
    CREATE TABLE IF NOT EXISTS $_tableName(
    $_columnId STRING PRIMARY KEY,
    $_columnTitle STRING NOT NULL,
    $_columnNote STRING NOT NULL,
    $_columnIsDone INTEGER NOT NULL,
    $_columnCreatedAt STRING NOT NULL,
    $_columnUpdatedAt STRING NOT NULL,
    $_columnCompletedAt STRING NOT NULL)
    ''');

  // Method to insert a single Todo into the database
  Future<void> insertOne(Todo todo) => _db!.insert(_tableName, todo.toJson());

  // Method to query all Todos from the database
  Future<List<Map<String, dynamic>>> queryAll() => _db!.query(_tableName);

  // Method to query completed Todos from the database
  Future<List<Map<String, dynamic>>> queryCompletedTodos() => _db!.query(
        _tableName,
        where: '$_columnIsDone = ?',
        whereArgs: [1],
      );

  // Method to query pending Todos from the database
  Future<List<Map<String, dynamic>>> queryPendingTodos() => _db!.query(
        _tableName,
        where: '$_columnIsDone = ?',
        whereArgs: [0],
      );

  // Method to update a Todo in the database
  Future<void> updateTodo(Todo todo) => _db!.update(
        _tableName,
        todo.toJson(),
        where: '$_columnId = ?',
        whereArgs: [todo.id],
      );

  // Method to delete a Todo from the database by ID
  Future<void> delete(String id) => _db!.delete(
        _tableName,
        where: '$_columnId = ?',
        whereArgs: [id],
      );

  // Method to delete all Todos from the database
  Future<void> deleteAll() => _db!.delete(_tableName);

  // Method to close the database connection
  void close() {
    if (_db != null) _db!.close();
  }
}
