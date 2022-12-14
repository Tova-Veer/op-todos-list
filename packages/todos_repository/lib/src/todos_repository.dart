// ignore_for_file: public_member_api_docs

import 'package:todos_api/todos_api.dart';

class TodosRepository {
  /// {@macro todos_repository}
  const TodosRepository({
    required TodosApi todosApi,
  }) : _todosApi = todosApi;

  final TodosApi _todosApi;

  Stream<List<Todo>> getTodos() => _todosApi.getTodos();

  Future<void> saveTodo(Todo todo) => _todosApi.saveTodo(todo);

  Future<void> deleteTodo(String id) => _todosApi.deleteTodo(id);
  
  Future<int> clearCompleted() => _todosApi.clearCompleted();
}
