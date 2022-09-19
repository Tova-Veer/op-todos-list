// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:todos_api/todos_api.dart';
import 'package:todos_repository/todos_repository.dart';
import 'package:todo_list/app/app.dart';
import 'package:todo_list/app/app_bloc_observer.dart';

void bootstrap({required TodosApi todosApi}) {
  FlutterError.onError = (details) =>
      {log(details.exceptionAsString(), stackTrace: details.stack)};

  Bloc.observer = AppBlocObserver();

  final todosRepository = TodosRepository(todosApi: todosApi);

  runZonedGuarded(
    () => runApp(App(todosRepository: todosRepository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
