import 'package:codingjr_todo/models/models.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

final class TodoDB extends GetxService {
  static const _dbName = 'todo.db';
  static const _dbVersion = 1;
  static const _tableName = 'Todo';

  static const _columnId = 'id';
  static const _columnTitle = 'title';
  static const _columnNote = 'note';
  static const _columnIsDone = 'is_done';
  static const _columnCreatedAt = 'created_at';
  static const _columnUpdatedAt = 'updated_at';
  static const _columnCompletedAt = 'completed_at';

  Database? _db;

  Future<Database> init() async {
    if (_db != null) return _db!;

    final dbPath = await getDatabasesPath().then(
      (path) => path + _dbName,
    );

    _db = await openDatabase(
      dbPath,
      onCreate: _onCreate,
      version: _dbVersion,
    );

    return _db!;
  }

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

  Future<void> insertOne(Todo todo) => _db!.insert(_tableName, todo.toJson());

  Future<List<Map<String, dynamic>>> queryAll() => _db!.query(_tableName);

  Future<List<Map<String, dynamic>>> queryCompletedTodos() => _db!.query(
        _tableName,
        where: '$_columnIsDone = ?',
        whereArgs: [1],
      );

  Future<List<Map<String, dynamic>>> queryPendingTodos() => _db!.query(
        _tableName,
        where: '$_columnIsDone = ?',
        whereArgs: [0],
      );

  Future<void> updateTodo(Todo todo) => _db!.update(
        _tableName,
        todo.toJson(),
        where: '$_columnId = ?',
        whereArgs: [todo.id],
      );

  Future<void> delete(String id) => _db!.delete(
        _tableName,
        where: '$_columnId = ?',
        whereArgs: [id],
      );

  Future<void> deleteAll() => _db!.delete(_tableName);

  void close() {
    if (_db != null) _db!.close();
  }
}
