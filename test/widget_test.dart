// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:expandable_tile_demo/main.dart';

void main() {
  testWidgets('Tile expands smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: const ExpandableTile(
          mainText: "Line 1\nLine 2\nLine 3",
          // use a subText so that the Brief/Full labels will be present
          subText: "Sub text",
        ),
      ),
    );

    expect(find.textContaining('Line 1'), findsOne);
    // Even though this is not displayed when collapsed, it *is* still in the
    //  widget
    expect(find.textContaining('Line 3'), findsOne);

    expect(find.byKey(const ValueKey("AnimatedSize")), findsOne);
    expect(find.byKey(const ValueKey("ExpandIcon")), findsOne);
    final tile = find.byKey(const ValueKey("ExpandableTile"));
    expect(tile, findsOne);

    // Initially collapsed
    expect(find.textContaining("Brief"), findsOne);
    expect(find.textContaining("Full"), findsNothing);

    // Expand
    await tester.tap(tile);
    await tester.pump();
    // Now expanded
    expect(find.textContaining("Brief"), findsNothing);
    expect(find.textContaining("Full"), findsOne);

    // Collapse
    await tester.tap(tile);
    await tester.pump();
    // Now collapsed
    expect(find.textContaining("Brief"), findsOne);
    expect(find.textContaining("Full"), findsNothing);
  });
}
