part of 'todos_overview_bloc.dart';

abstract class TodosOverviewEvent extends Equatable {
  const TodosOverviewEvent();

  @override
  List<Object> get props => [];
}

class TodosOverviewSubscriptionRequestedEvent extends TodosOverviewEvent {
  const TodosOverviewSubscriptionRequestedEvent();
}

class TodosOverviewTodoCompletionToggledEvent extends TodosOverviewEvent {
  const TodosOverviewTodoCompletionToggledEvent({
    required this.todo, 
    required this.toggled,
  });

  final Todo todo;
  final bool toggled;

  @override
  List<Object> get props => [todo, toggled];
}

class TodosOverviewTodoDeletedEvent extends TodosOverviewEvent {
  const TodosOverviewTodoDeletedEvent({required this.todo});

  final Todo todo;

  @override
  List<Object> get props => [todo];
}

class TodosOverviewUndoDeletionEvent extends TodosOverviewEvent {
  const TodosOverviewUndoDeletionEvent();
}

class TodosOverviewClearCompletedEvent extends TodosOverviewEvent {
  const TodosOverviewClearCompletedEvent();
}
