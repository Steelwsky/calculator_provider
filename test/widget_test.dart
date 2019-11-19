// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:provider_calc_expanded/main.dart';

void main() {
//  testWidgets('find buttons and textview', (WidgetTester tester) async {
//    await tester.pumpWidget(MyApp());
//    await tester.pump();
//  });

  testWidgets('buttons updating textview', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    await tester.pump();

    final textFinder = find.byKey(ValueKey('textview'));
    final btnFinder = find.byKey(ValueKey('btn4'));
    final btnFinder2 = find.byKey(ValueKey('btn6'));
    final oprFinder = find.byKey(ValueKey('btn+'));

    expect(textFinder, findsOneWidget);
    expect(btnFinder, findsOneWidget);
    expect(btnFinder2, findsOneWidget);
    expect(oprFinder, findsOneWidget);
    final txtview0 = textFinder.evaluate().single.widget as Text;
    expect(txtview0.data, equals('0'));
    print ('my print: ${txtview0.data}');
    await tester.tap(btnFinder);
    await tester.pump();
    await tester.tap(btnFinder);
    await tester.pump();
    final txtview2 = textFinder.evaluate().single.widget as Text;
    print ('my print: ${txtview2.data}');
    expect (txtview2.data, equals('44'));


//    print(textFinder.evaluate().first)



//    expect(find.text('0'), findsOneWidget);
//    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
//    await tester.tap(find.byIcon(Icons.add));
//    await tester.pump();

    // Verify that our counter has incremented.
//    expect(find.text('0'), findsNothing);
//    expect(find.text('1'), findsOneWidget);
  });
}
