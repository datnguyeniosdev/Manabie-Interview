// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manabie_interview/helpers/todo_provider.dart';
import 'package:manabie_interview/main.dart';
import 'package:manabie_interview/models/TodoEntity.dart';
import 'package:manabie_interview/repositories/main_repository.dart';
import 'package:manabie_interview/widgets/home_screen.dart';
import 'package:manabie_interview/widgets/todos.dart';
import 'package:mocktail/mocktail.dart';

class MainRepoMock extends Mock implements Mainrepository {}

Future<void> main() async {
  testWidgets('Todo UI test', (WidgetTester tester) async {
    final Mainrepository repoMock = MainRepoMock();
    // Build our app and trigger a frame.

    when(() => repoMock.getAllTask()).thenAnswer((invocation) async => [
          Todo.fromMap({columnTitle: 'Test 1', columnDone: true}),
          Todo.fromMap({columnTitle: 'Test 2', columnDone: false})
        ]);
    when(() => repoMock.getIncompleTask()).thenAnswer((invocation) async => [
          Todo.fromMap({columnTitle: 'Test 2', columnDone: false})
        ]);
    when(() => repoMock.getcompledTask()).thenAnswer((invocation) async => [
          Todo.fromMap({columnTitle: 'Test 1', columnDone: true})
        ]);

    await tester.pumpWidget(MyApp(repoMock));
    const emptyWidget = Text('No data to display, please create a new task');
    final emptyFinder = find.byWidget(emptyWidget);
    expect(emptyFinder, findsNothing);
  });
}
