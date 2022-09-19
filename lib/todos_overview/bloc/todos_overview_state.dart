part of 'todos_overview_bloc.dart';

enum TodosOverviewStatus { initial, loading, success, error }

class TodosOverviewState extends Equatable {
  const TodosOverviewState({
    this.status = TodosOverviewStatus.initial,
    this.todos = const[],
    this.lastDeletedTodo,
  });

  final TodosOverviewStatus status;
  final List<Todo> todos;
  final Todo? lastDeletedTodo;

  @override
  List<Object> get props => [status, todos];

  TodosOverviewState copyWith({
    TodosOverviewStatus? status,
    List<Todo>? todos,
    Todo? Function()? lastDeletedTodo,
  }) {
    return TodosOverviewState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      // We need to be able to set this to null
      lastDeletedTodo: lastDeletedTodo != null ? lastDeletedTodo() : this.lastDeletedTodo,
    );
  }
}
