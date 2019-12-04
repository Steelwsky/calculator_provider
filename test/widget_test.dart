import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider_calc_expanded/main.dart';

//TODO to fix onPercentage 13,14 tests, i have to create decimalFormatHelper

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

  testWidgets('should be 0 after 2 or more taps on ZERO button',
      (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonZero, tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonZero, tester);
    thenResultShouldBe('0');
  });

  testWidgets('should be 400 after user press on 4 and twice on ZERO button',
      (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonZero, tester);
    thenResultShouldBe('40');
    await whenUserPressButton(buttonZero, tester);
    thenResultShouldBe('400');
  });

  testWidgets('plus sign does not show after user press plusButton',
      (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('0');
  });

  testWidgets(
      '+ sign moves currentResultView from num1 to num2 and textview shows num2: 7',
      (WidgetTester tester) async {
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

  testWidgets('expected to get 7.0 after: 0 + 7 =',
      (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('7.0');
  });

  testWidgets('expected to get 14.0 after: 7 + =', (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('14.0');
  });

  testWidgets('result should be 11.0 after user press: 4, +, 7, =.',
      (WidgetTester tester) async {
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

  testWidgets('result should be 4 after user press: 4, +, 7, =, 4, + .',
          (WidgetTester tester) async {
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
        await whenUserPressButton(buttonFour, tester);
        thenResultShouldBe('4');
        await whenUserPressButton(buttonPlus, tester);
        thenResultShouldBe('4');
      });

  testWidgets('should be 110 after user add 40 and 70',
      (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonZero, tester);
    thenResultShouldBe('40');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('40');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonZero, tester);
    thenResultShouldBe('70');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('110.0');
  });

  testWidgets('result should be -3.0 after user press: 4, +, -, 7, = ',
      (WidgetTester tester) async {
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

  testWidgets('result should be 7 after user press + after first math result',
      (WidgetTester tester) async {
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
      'result should be 18.0 after user press +, 7 and = after first math result',
      (WidgetTester tester) async {
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

  testWidgets('should be INFINITY by calculating 7 / 0 =',
      (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonDivide, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonZero, tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('Infinity');
  });

  testWidgets('should be 7 as num1 and a result after getting INFINITY',
      (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonDivide, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonZero, tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('Infinity');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
  });

  testWidgets('should be 11.0 after new calculating after getting INFINITY',
          (WidgetTester tester) async {
        await pumpGivenApp(tester);
        thenResultShouldBe('0');
        await whenUserPressButton(buttonSeven, tester);
        thenResultShouldBe('7');
        await whenUserPressButton(buttonDivide, tester);
        thenResultShouldBe('7');
        await whenUserPressButton(buttonZero, tester);
        thenResultShouldBe('0');
        await whenUserPressButton(buttonEqual, tester);
        thenResultShouldBe('Infinity');
        await whenUserPressButton(buttonSeven, tester);
        thenResultShouldBe('7');
        await whenUserPressButton(buttonPlus, tester);
        thenResultShouldBe('7');
        await whenUserPressButton(buttonFour, tester);
        thenResultShouldBe('4');
        await whenUserPressButton(buttonEqual, tester);
        thenResultShouldBe('11.0');
      });

  testWidgets('simple divide test: 7 / 4 should give 1.75',
      (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonDivide, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('1.75');
  });

  testWidgets(
      'should calculate after both nums are taken and operator as well, '
      '4 + 7 + = 11.0', (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('11.0');
  });

  testWidgets('7 + 4 + = 22.0', (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('11.0');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('22.0');
  });

  testWidgets('7 + 4 + 7 = 18.0', (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('11.0');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('18.0');
  });

  testWidgets('7 + 4 - 4 = 3.0', (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonMinus, tester);
    thenResultShouldBe('11.0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('7.0');
  });

  testWidgets(
    'testing onDecimal 1: user press 4, DOT button and 7. should be 4.7', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonDecimal, tester);
    thenResultShouldBe('4.');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('4.7');
  },);

  testWidgets(
    'testing onDecimal 2: user press 4 and DOT button TWICE: 4 . . => shoud be 4.', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonDecimal, tester);
    thenResultShouldBe('4.');
    await whenUserPressButton(buttonDecimal, tester);
    thenResultShouldBe('4.');
  },);

  testWidgets(
    'testing onDecimal 3: user press 4, DOT button, 7 and DOT button again => should be 4.7 ', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonDecimal, tester);
    thenResultShouldBe('4.');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('4.7');
    await whenUserPressButton(buttonDecimal, tester);
    thenResultShouldBe('4.7');
  },);

  testWidgets(
    'testing onDecimal 4: user press 4, DOT button and 0 twice. should be 4.00', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonDecimal, tester);
    thenResultShouldBe('4.');
    await whenUserPressButton(buttonZero, tester);
    thenResultShouldBe('4.0');
    await whenUserPressButton(buttonZero, tester);
    thenResultShouldBe('4.00');
  },);

  testWidgets(
    'testing onDecimal 5: user press DOT button and 4 => should be 0.4', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonDecimal, tester);
    thenResultShouldBe('0.');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('0.4');
  },);

  testWidgets(
    'testing onDecimal 6: user press DOT button, DOT button and then 4 => should be 0.4', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonDecimal, tester);
    thenResultShouldBe('0.');
    await whenUserPressButton(buttonDecimal, tester);
    thenResultShouldBe('0.');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('0.4');
  },);

  testWidgets(
    'testing onDecimal 7: user press 4, +  DOT button, then 4 and = button => should be 4.4', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonDecimal, tester);
    thenResultShouldBe('0.');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('0.4');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('4.4');
  },);

  testWidgets(
    'testing onDecimal 8: user press 4, +, 4, =. Then DOT button and 4 => should be 0.4', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('8.0');
    await whenUserPressButton(buttonDecimal, tester);
    thenResultShouldBe('0.');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('0.4');
  },);


  testWidgets(
    'testing onPlusMinus 1: should be 0 when user press +- after app is pumped', (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonPlusMinus, tester);
    thenResultShouldBe('0');
  },);

  testWidgets(
    'testing onPlusMinus 2: should be 0 when user press +-, 0 , 0 after app is pumped', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonPlusMinus, tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonZero, tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonZero, tester);
    thenResultShouldBe('0');
  },);

  testWidgets(
    'testing onPlusMinus 3: should be 4 when user press +-, 4 after app is pumped', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonPlusMinus, tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
  },);

  testWidgets(
    'testing onPlusMinus 4: user press 4, then +- => should be -4', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlusMinus, tester);
    thenResultShouldBe('-4');

  },);

  testWidgets(
    'testing onPlusMinus 5: user press 4, then +-, then +- => should be 4', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlusMinus, tester);
    thenResultShouldBe('-4');
    await whenUserPressButton(buttonPlusMinus, tester);
    thenResultShouldBe('4');
  },);

  testWidgets(
    'testing onPlusMinus 6: user press 4, +, then 7, +-, = button => should be -3.0', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonPlusMinus, tester);
    thenResultShouldBe('-7');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('-3.0');
  },);

  testWidgets(
    'testing onPlusMinus 7: user press 4, +, +-, then 7, and = button => should be 11.0', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlusMinus, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('11.0');
  },);

  testWidgets('testing onPercentage 1: user press 4 and % => should be 0.04', (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPercentage, tester);
    thenResultShouldBe('0.04');
  },);

  testWidgets('testing onPercentage 2: user press 4, +, 7, % = 4.28', (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonPercentage, tester);
    thenResultShouldBe('0.28');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('4.28');
  },);

  testWidgets('testing onPercentage 3: user press 4, *, 7, % = 0.28', (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonMulti, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonPercentage, tester);
    thenResultShouldBe('0.07');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('0.28');
  },);

  testWidgets('testing onPercentage 4: user press 4 and % and % => should be 0.0004', (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPercentage, tester);
    thenResultShouldBe('0.04');
    await whenUserPressButton(buttonPercentage, tester);
    thenResultShouldBe('0.0004');
  },);

  testWidgets('testing onPercentage 5: user press 4, *, 7, % = 0.28 + 4 = 4.28', (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonMulti, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonPercentage, tester);
    thenResultShouldBe('0.07');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('0.28');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('0.28');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('4.28');
  },);

  testWidgets(
    'testing onPercentage 6: user press 4 and % and .decimalButton => should be 0.', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPercentage, tester);
    thenResultShouldBe('0.04');
    await whenUserPressButton(buttonDecimal, tester);
    thenResultShouldBe('0.');
  },);

  testWidgets('testing onPercentage 7: user press 4, % and 4 => should be 4', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPercentage, tester);
    thenResultShouldBe('0.04');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
  },);

  testWidgets(
    'testing onPercentage 8: user press 4, +, 7, % and 4 => should be 4', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonPercentage, tester);
    thenResultShouldBe('0.28');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
  },);

  testWidgets(
    'testing onPercentage 9: user press 4, +, 7, % and 4, + 7 => should be 15', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonPercentage, tester);
    thenResultShouldBe('0.28');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('8.0');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('15.0');
  },);

  testWidgets(
    'testing onPercentage 10: user press 4, %, 4, +, 7 => should be 11', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPercentage, tester);
    thenResultShouldBe('0.04');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('11.0');
  },);

  testWidgets(
    'testing onPercentage 11: user press 4, %, .DOTBUTTON, 7, + , 7 = button => should be 7.7', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPercentage, tester);
    thenResultShouldBe('0.04');
    await whenUserPressButton(buttonDecimal, tester);
    thenResultShouldBe('0.');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('0.7');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('0.7');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('7.7');
  },);

  testWidgets(
    'testing onPercentage 12: user press 4, + 7, %, .DOTBUTTON, 7, + , 7 = button => should be 11.7', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonPercentage, tester);
    thenResultShouldBe('0.28');
    await whenUserPressButton(buttonDecimal, tester);
    thenResultShouldBe('0.');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('0.7');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('4.7');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('11.7');
  },);

  testWidgets('testing onPercentage 13: user press 4, + 7, %, .DOTBUTTON, 7, + , 7 = button => should be 11.7. '
        'AND then DOTBUTTON, 7 + 4, % = button => should be 7.28 ', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonPercentage, tester);
    thenResultShouldBe('0.28');
    await whenUserPressButton(buttonDecimal, tester);
    thenResultShouldBe('0.');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('0.7');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('4.7');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('7');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('11.7');
    await whenUserPressButton(buttonDecimal, tester);
    thenResultShouldBe('0.');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('0.7');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('0.7');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPercentage, tester);
    thenResultShouldBe('0.028');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('0.728');
  },);

  testWidgets('testing onPercentage 14:  DOTBUTTON, 7 + 4, % = button => should be 7.28 ', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonDecimal, tester);
    thenResultShouldBe('0.');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('0.7');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('0.7');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPercentage, tester);
    thenResultShouldBe('0.028');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('0.728');
  },);

  testWidgets('testing onPercentage 15:  4, %, + DOTBUTTON, 7 = button => should be 7.28 ', (
      WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonPercentage, tester);
    thenResultShouldBe('0.04');
    await whenUserPressButton(buttonPlus, tester);
    thenResultShouldBe('0.04');
    await whenUserPressButton(buttonDecimal, tester);
    thenResultShouldBe('0.');
    await whenUserPressButton(buttonSeven, tester);
    thenResultShouldBe('0.7');
    await whenUserPressButton(buttonEqual, tester);
    thenResultShouldBe('0.74');
  },);

  testWidgets('check clear(), must be 0', (WidgetTester tester) async {
    await pumpGivenApp(tester);
    thenResultShouldBe('0');
    await whenUserPressButton(buttonFour, tester);
    thenResultShouldBe('4');
    await whenUserPressButton(buttonClear, tester);
    thenResultShouldBe('0');
  });
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

Finder get buttonZero => find.byKey(ValueKey('button0'));

Finder get buttonFour => find.byKey(ValueKey('button4'));

Finder get buttonSeven => find.byKey(ValueKey('button7'));

Finder get buttonPlus => find.byKey(ValueKey('button+'));

Finder get buttonEqual => find.byKey(ValueKey('button='));

Finder get buttonMinus => find.byKey(ValueKey('button-'));

Finder get buttonMulti => find.byKey(ValueKey('button*'));

Finder get buttonDivide => find.byKey(ValueKey('button/'));

Finder get buttonDecimal => find.byKey(ValueKey('button.'));

Finder get buttonPlusMinus => find.byKey(ValueKey('button+-'));

Finder get buttonPercentage => find.byKey(ValueKey('button%'));

Finder get buttonClear => find.byKey(ValueKey('buttonAC'));

String get currentResult =>
    (textViewResultFinder.evaluate().single.widget as Text).data;
