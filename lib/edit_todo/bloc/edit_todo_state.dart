part of 'edit_todo_bloc.dart';

enum EditTodoStatus { initial, success, error, loading }

class EditTodoState extends Equatable {
  const EditTodoState({
    this.initialTodo,
    this.status = EditTodoStatus.initial,
    this.title = '',
    this.details = '',
  });

  final Todo? initialTodo;

  final EditTodoStatus status;
  final String title;
  final String details;
  
  @override
  List<Object> get props => [status, title, details];

  bool get isNewTodo => initialTodo == null;

  // intiialTodo should not change
  EditTodoState copyWith({
    EditTodoStatus? status,
    String? title,
    String? details,
  }) {
    return EditTodoState(
      initialTodo: initialTodo,
      status: status ?? this.status,
      title: title ?? this.title,
      details: details ?? this.details,
    );
  }
}
