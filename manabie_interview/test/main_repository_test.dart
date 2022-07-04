import 'package:flutter_test/flutter_test.dart';
import 'package:manabie_interview/helpers/todo_provider.dart';
import 'package:manabie_interview/repositories/main_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Initialize sqflite for test.
void sqfliteTestInit() async {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;
}

Future main() async {
  sqfliteTestInit();
  await TodoProvider.shared.open(inMemoryDatabasePath);
  group("Localstore and storage func", () {
    final repo = MainrepositoryImpl(dataProvider: TodoProvider.shared);
    final task = Todo.fromMap({"title": "Task-test 1", "done": false});
    test('Create todo', () async {
      final result = await repo.create(task);
      expect(result, task);
    });
    test('get a todo by id', () async {
      final result = await repo.getTask(task.id ?? 0);
      expect(result?.id, task.id);
    });
    test('Get all todo', () async {
      final result = await repo.getAllTask();
      expect(result.length, 1);
    });
    test('Get incompleted task', () async {
      final result = await repo.getIncompleTask();
      expect(result.length, 1);
    });
    test('Get completed task', () async {
      final result = await repo.getcompledTask();
      expect(result.length, 0);
    });
    test('Change state task', () async {
      task.done = true;
      await repo.updateTask(task);
      final result = await repo.getTask(task.id ?? 0);
      final results = await repo.getcompledTask();
      expect(results.length, 1);
      expect(result?.done, true);
    });
    test('delete a task', () async {
      task.done = true;
      await repo.deleteTask(task.id ?? 0);
      final result = await repo.getTask(task.id ?? 0);
      expect(result, null);
    });
  });
}
