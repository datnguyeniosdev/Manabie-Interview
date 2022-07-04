import 'dart:async';

import 'package:flutter/material.dart';
import 'package:manabie_interview/helpers/todo_provider.dart';
import 'package:manabie_interview/repositories/main_repository.dart';
import 'package:manabie_interview/widgets/create_todo.dart';
import 'package:manabie_interview/widgets/todos.dart';

import 'commons/common_init.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Common.init();
    const app = MyApp();
    runApp(app);
  }, (error, stack) {
    print(error);
    print(stack);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Pages',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController controller;
  late Mainrepository mainRepo;
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();
  @override
  void initState() {
    mainRepo = MainrepositoryImpl(
        dataProvider: TodoProvider.shared); // will use to inject after
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo pages")),
      body: TabBarView(
        controller: controller,
        children: [
          FutureBuilder<List<Todo>>(
            initialData: [],
            future: mainRepo.getAllTask(),
            builder: ((context, snapshot) => TodosWidget(
                  items: snapshot.data ?? [],
                  taskStateChange: (task) async {
                    await mainRepo.updateTask(task);
                    setState(() {});
                  },
                )),
          ),
          FutureBuilder<List<Todo>>(
            initialData: [],
            future: mainRepo.getIncompleTask(),
            builder: ((context, snapshot) => TodosWidget(
                items: snapshot.data ?? [],
                taskStateChange: (task) async {
                  await mainRepo.updateTask(task);
                  setState(() {});
                })),
          ),
          FutureBuilder<List<Todo>>(
            initialData: [],
            future: mainRepo.getcompledTask(),
            builder: ((context, snapshot) => TodosWidget(
                items: snapshot.data ?? [],
                taskStateChange: (task) async {
                  await mainRepo.updateTask(task);
                  setState(() {});
                })),
          ),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: controller,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.blue,
        tabs: const [
          Tab(
            text: "All",
          ),
          Tab(
            text: "Incomplete",
          ),
          Tab(
            text: "Complete",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return CreateTodo();
            }),
          );
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
