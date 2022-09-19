part of 'edit_todo_bloc.dart';

abstract class EditTodoEvent extends Equatable {
  const EditTodoEvent();

  @override
  List<Object> get props => [];
}

class EditTodoTitleUpdatedEvent extends EditTodoEvent {
  const EditTodoTitleUpdatedEvent({
    required this.title,
  });

  final String title;

  @override
  List<Object> get props => [title];
}

class EditTodoDetailsUpdatedEvent extends EditTodoEvent {
  const EditTodoDetailsUpdatedEvent({
    required this.details,
  });

  final String details;

  @override
  List<Object> get props => [details];
}

class EditTodoSubmittedEvent extends EditTodoEvent { }
