
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repository/todos_repository.dart';

import 'bloc/edit_todo_bloc.dart';

class EditTodoPage extends StatelessWidget {
  const EditTodoPage({super.key});

  static Route<void> route({Todo? todo}) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => EditTodoBloc(
          todosRepository: context.read<TodosRepository>(),
          todo: todo,
        ),
        child: const EditTodoPage(),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<EditTodoBloc, EditTodoState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == EditTodoStatus.success) {
          Navigator.of(context).pop(); // Todo updated, lick the ballsacks!
        }
      },
      child: const EditTodoView(),
    );
  }
}

class EditTodoView extends StatelessWidget {
  const EditTodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.read<EditTodoBloc>().state.isNewTodo 
                  ? 'Add Todo'
                  : 'Edit Todo',
        ),
      ),
      body: Center(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                TextFormField(
                  initialValue: context.read<EditTodoBloc>().state.title,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter a title!',
                  ),
                  onChanged: (value) {
                    context.read<EditTodoBloc>().add(
                      EditTodoTitleUpdatedEvent(title: value),
                    );
                  },
                ),
                TextFormField(
                  initialValue: context.read<EditTodoBloc>().state.details,
                  decoration: const InputDecoration(
                    labelText: 'Details',
                    hintText: 'Enter some extra details!',
                  ),
                  onChanged: (value) {
                    context.read<EditTodoBloc>().add(
                      EditTodoDetailsUpdatedEvent(details: value),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: FloatingActionButton(
                    tooltip: 'Save Todo',
                    child: context.read<EditTodoBloc>().state.status == EditTodoStatus.loading 
                            ? const CupertinoActivityIndicator()
                            : const Icon(Icons.check_rounded),
                    onPressed: () {
                      if (context.read<EditTodoBloc>().state.status != EditTodoStatus.loading) {
                        context.read<EditTodoBloc>().add(EditTodoSubmittedEvent());
                      }
                    },
                  ),
                )
              ]
            ),
          ),
        )
      ),
    );
  }
}
