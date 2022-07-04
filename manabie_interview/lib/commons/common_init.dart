import 'package:manabie_interview/helpers/todo_provider.dart';

class Common {
  static Future<void> init() async {
    await TodoProvider.shared.open(tableTodo);
  }
}
