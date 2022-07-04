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
import 'package:sqflite/sqlite_api.dart';

void main() {
  testWidgets('Todo UI test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await TodoProvider.shared.open(inMemoryDatabasePath);
    await tester.pumpWidget(const MyApp());
    expect(0, 0);
  });
}
