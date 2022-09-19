import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/edit_todo/edit_todo_page.dart';
import 'package:todo_list/todos_overview/bloc/todos_overview_bloc.dart';
import 'package:todos_repository/todos_repository.dart';

class TodosOverviewListTile extends StatelessWidget {
  const TodosOverviewListTile({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('todosOverviewListTile_dismissible_${todo.id}'), 
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(EditTodoPage.route(todo: todo));
        },
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        leading: Checkbox(
          value: todo.completed,
          onChanged: (value) {
            context.read<TodosOverviewBloc>().add(
              TodosOverviewTodoCompletionToggledEvent(
                todo: todo,
                toggled: value!,
              ),
            );
          },
        ),
        title: Text(
          todo.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          todo.details,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      onDismissed: (_) {
        context.read<TodosOverviewBloc>().add(
          TodosOverviewTodoDeletedEvent(todo: todo),
        );
      },
    );
  }
}
