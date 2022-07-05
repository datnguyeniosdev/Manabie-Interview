import 'package:manabie_interview/helpers/todo_provider.dart';
import 'package:manabie_interview/models/TodoEntity.dart';

class Common {
  static Future<void> init() async {
    await TodoProvider.shared.open(tableTodo);
  }
}
