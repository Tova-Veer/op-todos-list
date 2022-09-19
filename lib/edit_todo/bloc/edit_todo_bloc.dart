import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_repository/todos_repository.dart';

part 'edit_todo_event.dart';
part 'edit_todo_state.dart';

class EditTodoBloc extends Bloc<EditTodoEvent, EditTodoState> {
  EditTodoBloc({
    required TodosRepository todosRepository, 
    Todo? todo,
  }) : _todosRepository = todosRepository,
    super(
      EditTodoState(
        initialTodo: todo, 
        title: todo?.title ?? '', 
        details: todo?.details ?? '',
      ),
    ) {
    on<EditTodoTitleUpdatedEvent>(_onTitleUpdated);
    on<EditTodoDetailsUpdatedEvent>(_onDetailsUpdated);
    on<EditTodoSubmittedEvent>(_onSubmitted);
  }

  final TodosRepository _todosRepository;

  Future<void> _onTitleUpdated(
    EditTodoTitleUpdatedEvent event,
    Emitter<EditTodoState> emit,
  ) async {
    emit(state.copyWith(title: event.title));
  }

  Future<void> _onDetailsUpdated(
    EditTodoDetailsUpdatedEvent event,
    Emitter<EditTodoState> emit,
  ) async {
    emit(state.copyWith(details: event.details));
  }

  Future<void> _onSubmitted(
    EditTodoSubmittedEvent event,
    Emitter<EditTodoState> emit,
  ) async {
    assert(
      state.title.isNotEmpty, 
      'Title of todo cannot be empty!',
    );
    final Todo todo;
    if (state.isNewTodo) {
      todo = Todo(
        title: state.title, 
        details: state.details, 
      );
    } else {
      todo = state.initialTodo!.copyWith(
        title: state.title, 
        details: state.details,
      );
    }
    emit(state.copyWith(status: EditTodoStatus.loading));
    await _todosRepository.saveTodo(todo).then((_) {
      emit(state.copyWith(status: EditTodoStatus.success));
    }).catchError((_) {
      emit(state.copyWith(status: EditTodoStatus.error));
    });
  }
}
