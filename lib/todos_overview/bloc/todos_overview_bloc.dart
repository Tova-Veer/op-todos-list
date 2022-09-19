import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repository/todos_repository.dart';

part 'todos_overview_state.dart';
part 'todos_overview_event.dart';

class TodosOverviewBloc extends Bloc<TodosOverviewEvent, TodosOverviewState> {
  TodosOverviewBloc({required TodosRepository todosRepository}) : 
    _todosRepository = todosRepository,
    super(const TodosOverviewState()) 
  {
    on<TodosOverviewSubscriptionRequestedEvent>(_onSubscriptionRequested);
    on<TodosOverviewTodoCompletionToggledEvent>(_onTodoCompletionToggled);
    on<TodosOverviewTodoDeletedEvent>(_onTodoDeleted);
    on<TodosOverviewUndoDeletionEvent>(_onUndoDeletion);
    on<TodosOverviewClearCompletedEvent>(_onClearCompleted);
  }

  final TodosRepository _todosRepository;

  Future<void> _onSubscriptionRequested(
    TodosOverviewSubscriptionRequestedEvent event,
    Emitter<TodosOverviewState> emit,
  ) async {
    emit(state.copyWith(status: TodosOverviewStatus.loading));

    await emit.forEach(
      _todosRepository.getTodos(),
      onData: (List<Todo> todos) => state.copyWith(
        todos: todos, status: TodosOverviewStatus.success,
      ),
      onError: (_, __) => state.copyWith(
        status: TodosOverviewStatus.error,
      ),
    );
  }

  Future<void> _onTodoCompletionToggled(
    TodosOverviewTodoCompletionToggledEvent event,
    Emitter<TodosOverviewState> emit,
  ) async {
    await _todosRepository.saveTodo(
      event.todo.copyWith(completed: event.toggled),
    );
  }

  Future<void> _onTodoDeleted (
    TodosOverviewTodoDeletedEvent event,
    Emitter<TodosOverviewState> emit,
  ) async {
    await _todosRepository.deleteTodo(event.todo.id);
  }
  
  Future<void> _onUndoDeletion(
    TodosOverviewUndoDeletionEvent event,
    Emitter<TodosOverviewState> emit,
  ) async {
    assert (
      state.lastDeletedTodo != null,
      'lastDeletedTodo should not be null!',
    );
    await _todosRepository.saveTodo(state.lastDeletedTodo!);
    emit(state.copyWith(lastDeletedTodo: () => null,));
  }

  Future<void> _onClearCompleted(
    TodosOverviewClearCompletedEvent event, 
    Emitter<TodosOverviewState> emit,
  ) async {
    await _todosRepository.clearCompleted();
  }
}
