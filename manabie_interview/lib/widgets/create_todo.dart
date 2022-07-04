import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manabie_interview/helpers/todo_provider.dart';

class CreateTodo extends StatefulWidget {
  CreateTodo({Key? key}) : super(key: key);

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
        title: Text("Create Task"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [IconButton(onPressed: createTask, icon: Icon(Icons.done))],
      ),
      body: Column(
        children: [
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(hintText: "Task Name"),
          ),
          Row(
            children: [
              Text("Task completed:"),
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
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Warning"),
        content: Text("Task name do not empty."),
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
    await TodoProvider.shared.insert(task);
    Widget okButton = TextButton(
      child: Text("OK"),
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
      title: Text("Success"),
      content: Text("The task has been created."),
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
