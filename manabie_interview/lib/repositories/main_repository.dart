import 'dart:ffi';

import 'package:manabie_interview/helpers/todo_provider.dart';

abstract class Mainrepository {
  Future<List<Todo>> getAllTask();
  Future<List<Todo>> getIncompleTask();
  Future<List<Todo>> getcompledTask();
  Future<dynamic> updateTask(Todo task);
  Future<Todo> create(Todo task);
  Future<Todo?> getTask(int id);
  Future deleteTask(int id);
}

class MainrepositoryImpl implements Mainrepository {
  TodoProvider dataProvider;
  MainrepositoryImpl({
    required this.dataProvider,
  });
  @override
  Future<List<Todo>> getAllTask() async {
    return await dataProvider.all();
  }

  @override
  Future<List<Todo>> getIncompleTask() async {
    return await dataProvider.incompleted();
  }

  @override
  Future<List<Todo>> getcompledTask() async {
    return await dataProvider.completed();
  }

  @override
  Future<dynamic> updateTask(Todo task) async {
    return await dataProvider.update(task);
  }

  @override
  Future<Todo> create(Todo task) async {
    return await dataProvider.insert(task);
  }

  @override
  Future<Todo?> getTask(int id) async {
    return await dataProvider.getTodo(id);
  }

  @override
  Future deleteTask(int id) async {
    return await dataProvider.delete(id);
  }
}
