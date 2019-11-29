import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider_calc_expanded/main.dart';

void main() {
  testWidgets('pumped app shows 0 at the start', (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
  });

  testWidgets('should be 4 after user press 4 after app is pumped',
          (WidgetTester tester) async {
        await pumpGivenApp(tester);
        thenResultShouldBe('0');
        await whenUserPressButton(buttonFour, tester);
        thenResultShouldBe('4');
      });

  testWidgets('should be 44 after 2 taps on 4 button',
          (WidgetTester tester) async {
        await pumpGivenApp(tester);
        thenResultShouldBe('0');
        await whenUserPressButton(buttonFour, tester);
        thenResultShouldBe('4');
        await whenUserPressButton(buttonFour, tester);
        thenResultShouldBe('44');
  });

  testWidgets('plus sign does not show after user press plusButton', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('0');
  });

  testWidgets(
      '+ sign moves currentResultView from num1 to num2 and textview shows num2: 7', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
  });

  testWidgets('should show 0.0 after press: +, =', (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('0.0');
  });

  testWidgets(
      'expected to get 7.0 after: 0 + 7 =', (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('7.0');
  });


  testWidgets('result should be 11.0 after user press: 4, +, 7, =.', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('11.0');
  });

  testWidgets('result should be -3.0 after user press: 4, +, -, 7, = ', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonMinus, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('-3.0');
  });

  testWidgets('result should be 7 after user press + after first math result', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('11.0');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('11.0');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
  });

  testWidgets(
      'result should be 18.0 after user press +, 7 and = after first math result', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('11.0');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('11.0');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('18.0');
  });

  testWidgets(
      'check clear(), must be 0', (WidgetTester tester) async {}, skip: true);
}

Future<void> pumpGivenApp(WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
  await tester.pump();
}

Future<void> whenUserPressButton(Finder toPress, WidgetTester tester) async {
  await tester.tap(toPress);
  await tester.pump();
}

void thenResultShouldBe(String text) {
  expect(currentResult, text);
}

Finder get textViewResultFinder => find.byKey(ValueKey('textViewResult'));

Finder get buttonFour => find.byKey(ValueKey('button4'));

Finder get buttonSeven => find.byKey(ValueKey('button7'));

Finder get buttonPlus => find.byKey(ValueKey('button+'));

Finder get buttonEqual => find.byKey(ValueKey('button='));

Finder get buttonMinus => find.byKey(ValueKey('button-'));
//Finder get buttonMulti => find.byKey(ValueKey('button*'));
//Finder get buttonDivide => find.byKey(ValueKey('button/'));

String get currentResult =>
    (textViewResultFinder
        .evaluate()
        .single
        .widget as Text).data;
