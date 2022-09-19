import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/edit_todo/edit_todo.dart';
import 'package:todo_list/todos_overview/bloc/todos_overview_bloc.dart';
import 'package:todo_list/todos_overview/widgets/widgets.dart';
import 'package:todos_repository/todos_repository.dart';

class TodosOverviewPage extends StatelessWidget {
  const TodosOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosOverviewBloc(
        todosRepository: context.read<TodosRepository>(),
      )..add(const TodosOverviewSubscriptionRequestedEvent()), // Request initial todos
      child: const TodosOverviewView(),
    );
  }
}

class TodosOverviewView extends StatelessWidget {
  const TodosOverviewView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const[
          TodosOverviewOptionsButton()
        ],
        title: const Text('Todo List'),
      ),
      body: BlocBuilder<TodosOverviewBloc, TodosOverviewState>(
        builder: (context, state) {
          if (state.todos.isEmpty) {
            if (state.status == TodosOverviewStatus.loading) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state.status == TodosOverviewStatus.success) {
              return Center(
                child: Text(
                  'Nothing Left!',
                  style: Theme.of(context).textTheme.caption,
                ),
              );
            }
          }
          
          return CupertinoScrollbar(
            child: ListView(
              children: [
                for (final todo in state.todos)
                  TodosOverviewListTile(todo: todo)
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            EditTodoPage.route(),
          );
        },
      ),
    );
  } 
}
