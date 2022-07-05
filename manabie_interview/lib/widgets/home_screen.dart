import 'package:flutter/material.dart';
import 'package:manabie_interview/helpers/todo_provider.dart';
import 'package:manabie_interview/models/TodoEntity.dart';
import 'package:manabie_interview/repositories/main_repository.dart';
import 'package:manabie_interview/widgets/create_todo.dart';
import 'package:manabie_interview/widgets/todos.dart';

class MyHomePage extends StatefulWidget {
  final Mainrepository mainrepository;
  const MyHomePage(this.mainrepository, {Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController controller;
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();
  @override
  void initState() {
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
            future: widget.mainrepository.getAllTask(),
            builder: ((context, snapshot) => TodosWidget(
                  items: snapshot.data ?? [],
                  taskStateChange: (task) async {
                    await widget.mainrepository.updateTask(task);
                    setState(() {});
                  },
                )),
          ),
          FutureBuilder<List<Todo>>(
            initialData: [],
            future: widget.mainrepository.getIncompleTask(),
            builder: ((context, snapshot) => TodosWidget(
                items: snapshot.data ?? [],
                taskStateChange: (task) async {
                  await widget.mainrepository.updateTask(task);
                  setState(() {});
                })),
          ),
          FutureBuilder<List<Todo>>(
            initialData: [],
            future: widget.mainrepository.getcompledTask(),
            builder: ((context, snapshot) => TodosWidget(
                items: snapshot.data ?? [],
                taskStateChange: (task) async {
                  await widget.mainrepository.updateTask(task);
                  setState(() {});
                })),
          ),
        ],
      ),
      bottomNavigationBar: _bottomBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return CreateTodo(
                mainrepository: widget.mainrepository,
              );
            }),
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bottomBar() {
    return TabBar(
      controller: controller,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: const EdgeInsets.all(5.0),
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
    );
  }
}
