import 'dart:async';

import 'package:flutter/material.dart';
import 'package:manabie_interview/helpers/todo_provider.dart';
import 'package:manabie_interview/repositories/main_repository.dart';
import 'package:manabie_interview/widgets/home_screen.dart';

import 'commons/common_init.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Common.init();
    final app = MyApp(MainrepositoryImpl(dataProvider: TodoProvider.shared));
    runApp(app);
  }, (error, stack) {
    print(error);
    print(stack);
  });
}

class MyApp extends StatelessWidget {
  final Mainrepository mainRepo;
  const MyApp(this.mainRepo, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Pages',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(mainRepo),
    );
  }
}
