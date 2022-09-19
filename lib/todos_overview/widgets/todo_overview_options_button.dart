import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/todos_overview/bloc/todos_overview_bloc.dart';

enum Option { clearCompletedTodos }

class TodosOverviewOptionsButton extends StatelessWidget {
  const TodosOverviewOptionsButton({super.key});
  
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Option>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      onSelected: (option) {
        switch (option) {
          case Option.clearCompletedTodos:
            context.read<TodosOverviewBloc>().add(
              const TodosOverviewClearCompletedEvent(),
            );
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Option>>[
        const PopupMenuItem<Option>(
          value: Option.clearCompletedTodos,
          child: Text('Clear Completed Todos'),
        )
      ],
    );
  }
}