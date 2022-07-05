import 'package:flutter/material.dart';
import 'package:manabie_interview/models/TodoEntity.dart';

class TodosWidget extends StatelessWidget {
  List<Todo> items;
  Function(Todo)? taskStateChange;
  TodosWidget({Key? key, required this.items, this.taskStateChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? const Center(
            child: Text("No data to display, please create a new task"),
          )
        : ListView.builder(
            itemCount: items.length,
            itemBuilder: ((context, index) {
              final item = items[index];
              return ListTile(
                title: Text(item.title ?? ""),
                trailing: IconButton(
                  icon: Icon(
                    item.done == true
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                  ),
                  onPressed: () {
                    var task = items[index];
                    task.done = !(task.done ?? false);
                    if (taskStateChange != null) {
                      taskStateChange!(task);
                    }
                  },
                ),
              );
            }));
  }
}
