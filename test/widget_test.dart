// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:random_color_flutter/main.dart';

void main() {
  testWidgets('Verify initial text and background tap logic', 
  (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const Main());

    // Verify that "Hello there!" is visible on start.
    expect(find.text('Hello there!'), findsOneWidget);

    // Find the main GestureDetectopr
    final backgroundFinder = find.byType(GestureDetector).first;

    // Tap the background and re-render the frame
    await tester.tap(backgroundFinder);
    await tester.pumpAndSettle();

    // Verify that "Hello there!" is still visible
    expect(find.text('Hello there!'), findsOneWidget);

    // Verify the history list exists
    expect(find.byType(ListView), findsOneWidget);
  });
}
