import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_api/todos_api.dart';

/// {@template online_storage_todos_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class OnlineStorageTodosApi extends TodosApi { // TODO: Make shit change serverside
  /// {@macro online_storage_todos_api}
  OnlineStorageTodosApi() { 
    _init();    
  }

  final _todoStreamController = BehaviorSubject<List<Todo>>.seeded(const []);

  Future<void> _init() async {
    final response = await get(Uri.parse(
      'https://83o1ckfevh.execute-api.us-east-2.amazonaws.com/testing/todos',
      ),
    );
    final decodedResponse = jsonDecode(response.body) as List;
    final result = <Todo>[];
    for (final todo in decodedResponse) {
      result.add(Todo.fromJson(todo as Map<String, dynamic>));
    }
    _todoStreamController.add(result);
  }

  @override
  Stream<List<Todo>> getTodos() {
    return _todoStreamController.asBroadcastStream();
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = [..._todoStreamController.value]
    ..removeWhere((t) => t.id == id);
    _todoStreamController.add(todos);
    await delete(Uri.parse(
      'https://83o1ckfevh.execute-api.us-east-2.amazonaws.com/testing/todos',
      ), body: jsonEncode({'id': id}),
    );
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((t) => t.id == todo.id);
    if (todoIndex != -1) {
      todos[todoIndex] = todo;
    } else {
      todos.add(todo);
    }
    _todoStreamController.add(todos);
    final penis = await put(Uri.parse(
      'https://83o1ckfevh.execute-api.us-east-2.amazonaws.com/testing/todos',
      ), body: jsonEncode({'todo': todo.toJson()}),
    );
  }

  @override
  Future<int> clearCompleted() async {
    final todos = [..._todoStreamController.value];
    final initialLength = todos.length;
    todos.removeWhere((t) => t.completed);
    _todoStreamController.add(todos);
    return initialLength - todos.length;
  }
}
