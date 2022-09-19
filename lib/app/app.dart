import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/todos_overview/todos_overview.dart';
import 'package:todo_list/theme/theme.dart';
import 'package:todos_repository/todos_repository.dart';

class App extends StatelessWidget {
  const App({super.key, required this.todosRepository});

  final TodosRepository todosRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: todosRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: FlutterTodosTheme.light,
      darkTheme: FlutterTodosTheme.dark,
      home: const TodosOverviewPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
