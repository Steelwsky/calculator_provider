// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider_calc_expanded/main.dart';

void main() {
  testWidgets('should show 0 on app start', (WidgetTester tester) async {
    await givenAppIsPumped(tester);
    thenResultShouldBe('0');
  });

  testWidgets('should show 1 after user press 1', (WidgetTester tester) async {
    await givenAppIsPumped(tester);
    thenResultShouldBe('0');
    await whenUserPressesButton(button1, tester);
    thenResultShouldBe('1');
  });

  testWidgets('should show 11 after user press 1 then 1 again',
      (WidgetTester tester) async {
    await givenAppIsPumped(tester);
    thenResultShouldBe('0');
    await whenUserPressesButton(button1, tester);
    thenResultShouldBe('1');
    await whenUserPressesButton(button1, tester);
    thenResultShouldBe('11');
  });

  testWidgets('should show + after user press +', (WidgetTester tester) async {
    await givenAppIsPumped(tester);
    thenResultShouldBe('0');
    await whenUserPressesButton(button1, tester);
    thenResultShouldBe('1');
    await whenUserPressesButton(plusButton, tester);
    thenResultShouldBe('1+');
  });

  testWidgets('should show only one + after user press + again', (WidgetTester tester) async {
    await givenAppIsPumped(tester);
    thenResultShouldBe('0');
    await whenUserPressesButton(button1, tester);
    thenResultShouldBe('1');
    await whenUserPressesButton(plusButton, tester);
    thenResultShouldBe('1+');
    await whenUserPressesButton(plusButton, tester);
    thenResultShouldBe('1+');
  });

  testWidgets('should show 1+1', (WidgetTester tester) async {
    await givenAppIsPumped(tester);
    thenResultShouldBe('0');
    await whenUserPressesButton(button1, tester);
    thenResultShouldBe('1');
    await whenUserPressesButton(plusButton, tester);
    thenResultShouldBe('1+');
    await whenUserPressesButton(button1, tester);
    thenResultShouldBe('1+1');
  });

  testWidgets('should show 0+ after user tapped @+button@ after app is pumped', (WidgetTester tester) async {
    await givenAppIsPumped(tester);
    thenResultShouldBe('0');
    await whenUserPressesButton(plusButton, tester);
    thenResultShouldBe('0+');
  });

  testWidgets('should show 0+ after user tapped @+button@ after app is pumped', (WidgetTester tester) async {
    await givenAppIsPumped(tester);
    thenResultShouldBe('0');
    await whenUserPressesButton(plusButton, tester);
    thenResultShouldBe('0+');
  });

  testWidgets('should show 2 after user tapped 1, +, 1 and = after all', (WidgetTester tester) async {
    await givenAppIsPumped(tester);
    thenResultShouldBe('0');
    await whenUserPressesButton(button1, tester);
    thenResultShouldBe('1');
    await whenUserPressesButton(plusButton, tester);
    thenResultShouldBe('1+');
    await whenUserPressesButton(plusButton, tester);
    thenResultShouldBe('1+1');
    await whenUserPressesButton(equalButton, tester);
    thenResultShouldBe('2');
  });

  testWidgets('should show 0 after user tapped + and = after app is pumped', (WidgetTester tester) async {
    await givenAppIsPumped(tester);
    thenResultShouldBe('0');
    await whenUserPressesButton(plusButton, tester);
    thenResultShouldBe('0+');
    await whenUserPressesButton(equalButton, tester);
    thenResultShouldBe('0');
  });

  testWidgets('should show 1 after user tapped +, 1 and = after app is pumped', (WidgetTester tester) async {
    await givenAppIsPumped(tester);
    thenResultShouldBe('0');
    await whenUserPressesButton(plusButton, tester);
    thenResultShouldBe('0+');
    await whenUserPressesButton(button1, tester);
    thenResultShouldBe('0+1');
    await whenUserPressesButton(equalButton, tester);
    thenResultShouldBe('1');
  });

}


Future<void> givenAppIsPumped(WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
  await tester.pump();
}

Future<void> whenUserPressesButton(Finder toPress, WidgetTester tester) async {
  await tester.tap(toPress);
  await tester.pump();
}

void thenResultShouldBe(String text) {
  expect(currentResultText, text);
}

Finder get textViewResultFinder => find.byKey(ValueKey('textViewResult'));

Finder get button1 => find.byKey(ValueKey('button1'));

Finder get plusButton => find.byKey(ValueKey('plusButton'));

Finder get equalButton => find.byKey(ValueKey('equalButton'));

String get currentResultText =>
    (textViewResultFinder.evaluate().single.widget as Text).data;
