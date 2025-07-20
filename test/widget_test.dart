// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:album_viewer/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Album viewer app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for the app to load
    await tester.pumpAndSettle();

    // Verify that the app loads without crashing
    expect(find.byType(MaterialApp), findsOneWidget);

    // The app should show some content (either loading or error state)
    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('App title is correct', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for the app to load
    await tester.pumpAndSettle();

    // Verify the app title
    expect(find.text('Album Viewer'), findsOneWidget);
  });

  testWidgets('ListView is rendered for scrolling',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for the app to load
    await tester.pumpAndSettle();

    // Verify that a ListView is present (for scrolling)
    expect(find.byType(ListView), findsOneWidget);
  });
}
