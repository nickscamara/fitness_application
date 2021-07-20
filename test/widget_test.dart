// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fitness_application/main.dart';

void main() {
  group("first-task", () {
    testWidgets(
        'Stopwatch starts when start is pressed and stops when stop is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(child: MyApp()));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text("00:00"), findsOneWidget);
      expect(find.text("00:01"), findsNothing);

      await tester.tap(find.byKey(Key('start-button')));
      await tester.pump(const Duration(seconds: 2));

      expect(find.text("00:00"), findsNothing);
      expect(find.text('00:02'), findsOneWidget);

      await tester.tap(find.byKey(Key('stop-button')));
      await tester.pump(const Duration(seconds: 2));

      expect(find.text('00:02'), findsOneWidget);

      // get the provider and stop it
    });

  });
}
