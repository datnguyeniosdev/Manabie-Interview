import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:manabie_interview/models/TodoEntity.dart';

class TodoProvider {
  static TodoProvider shared = TodoProvider();
  late Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableTodo ( 
  $columnId integer primary key autoincrement, 
  $columnTitle text not null,
  $columnDone integer not null)
''');
    });
  }

  Future openMockDB(String path) async {
    var databaseFactory = databaseFactoryFfi;
    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
  }

  Future<List<Todo>> all() async {
    final todos = await db.query(tableTodo);
    return todos.map((e) => Todo.fromMap(e)).toList();
  }

  Future<List<Todo>> incompleted() async {
    final todos = await db.query(tableTodo, where: '$columnDone = 0');
    return todos.map((e) => Todo.fromMap(e)).toList();
  }

  Future<List<Todo>> completed() async {
    final todos = await db.query(tableTodo, where: '$columnDone = 1');
    return todos.map((e) => Todo.fromMap(e)).toList();
  }

  Future<Todo> insert(Todo todo) async {
    todo.id = await db.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<Todo?> getTodo(int id) async {
    List<Map<String, dynamic>> maps = await db.query(tableTodo,
        columns: [columnId, columnDone, columnTitle],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Todo.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {
    return await db.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  Future close() async => db.close();
}
