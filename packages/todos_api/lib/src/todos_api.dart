import "package:todos_api/todos_api.dart";

/// {@template todos_api}
/// Interface for an API that handles the access and modification of a list of Todos.
/// {@endtemplate}
abstract class TodosApi {
  /// {@macro todos_api}
  const TodosApi();

  Stream<List<Todo>> getTodos();

  Future<void> saveTodo(Todo todo);

  Future<void> deleteTodo(String id);

  Future<int> clearCompleted();
}
