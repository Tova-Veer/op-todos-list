// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/widgets.dart';
import 'package:online_storage_todos_api/online_storage_todos_api.dart';
import 'package:todo_list/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final todosApi = OnlineStorageTodosApi();

  bootstrap(todosApi: todosApi);
}
