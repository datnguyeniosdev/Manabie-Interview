import 'package:flutter/material.dart';
import 'package:manabie_interview/helpers/todo_provider.dart';
import 'package:manabie_interview/models/TodoEntity.dart';
import 'package:manabie_interview/repositories/main_repository.dart';

class CreateTodo extends StatefulWidget {
  final Mainrepository mainrepository;

  const CreateTodo({super.key, required this.mainrepository});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  late TextEditingController _textEditingController;
  bool isComplted = false;
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Task"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: createTask,
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(hintText: "Task Name"),
          ),
          Row(
            children: [
              const Text("Task completed:"),
              Checkbox(
                  value: isComplted,
                  onChanged: (value) {
                    setState(() {
                      isComplted = value ?? false;
                    });
                  }),
            ],
          )
        ],
      ),
    );
  }

  createTask() async {
    if (_textEditingController.text.isEmpty) {
      Widget okButton = TextButton(
        child: const Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: const Text("Warning"),
        content: const Text("Task name do not empty."),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      return;
    }
    final task = Todo();
    task.title = _textEditingController.text;
    task.done = isComplted;
    await widget.mainrepository.create(task);
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          _textEditingController.text = "";
          isComplted = false;
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Success"),
      content: const Text("The task has been created."),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
