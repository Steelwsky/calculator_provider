import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:intl/number_symbols.dart';

class CalcState {
  CalcState({
    this.num1 = '0',
    this.num2 = '',
    this.result = '0',
    this.operator,
  });

  final String num1;
  final String num2;
  final String result;
  final String operator;
}

class CalcController {
  final ValueNotifier<CalcState> state = ValueNotifier(CalcState());

  // не получилось уйти от введения bool
  bool isOnPercentageCalled = false;
  bool isOnDecimalCalled = false;

  void onNumber(String input) {
    printInfo('onNumber');
    // is needed to be clear
    if (state.value.result == 'Infinity' ||
        (state.value.num2 == '' &&
            state.value.operator == '=' &&
            decimalHelper(state.value.num1) == state.value.result)) {
      print('clear in onNumber');
      clear();
    }
    // FIRSTNUMBER
    if (state.value.operator == null) {
      if (isOnPercentageCalled) {
        print('isOnPercentageCalled, num1');
        if (isOnDecimalCalled) {
          print('isOnPercentageCalled, isOnDecimalCalled = true, num1');
          state.value = CalcState(
            num1: state.value.num1 + input,
            result: decimalHelper(state.value.num1 + input),
          );
          return;
        } else
          print('isOnPercentageCalled, isOnDecimalCalled = false, num1');
        state.value = CalcState(
          num1: input,
          result: input,
        );
        isOnPercentageCalled = false;
        return;
      }
      if (state.value.num1 == '0') {
        print('num1 = 0');
        final newState = CalcState(num1: input, result: input);
        state.value = newState;
        printInfo('onNumber');
      } else if (state.value.result.contains(',')) {
        print('contains(,)');
        final newState = CalcState(
            num1: state.value.num1 + input, result: state.value.result + input);
        state.value = newState;
        printInfo('onNumber contains dot');
      } else {
        print('onNumber: nothing special');
        final newState = CalcState(
          num1: state.value.num1 + input,
          result: decimalHelper(state.value.num1 + input),
        );
        state.value = newState;
        printInfo('onNumber');
      }
    }
    //SECONDNUMBER
    else {
      if (isOnPercentageCalled) {
        print('isOnPercentageCalled, num2');
        if (isOnDecimalCalled) {
          print('isOnPercentageCalled, isOnDecimalCalled = true, num2');
          state.value = CalcState(
            num1: state.value.num1,
            operator: state.value.operator,
            num2: state.value.num2 + input,
            result: decimalHelper(state.value.num2 + input),
          );
          isOnPercentageCalled = false;
          return;
        } else
          print('isOnPercentageCalled, isOnDecimalCalled = false, num2');
        state.value = CalcState(
          num1: state.value.num1,
          operator: state.value.operator,
          num2: input,
          result: input,
        );
        isOnPercentageCalled = false;
        return;
      }
      if (state.value.result.contains(',')) {
        print('contains(,)');
        final newState = CalcState(
          num1: state.value.num1,
          num2: state.value.num2 + input,
          operator: state.value.operator,
          result: state.value.num2.replaceAll('.', ',') + input,
        );
        state.value = newState;
        printInfo('onNumber contains dot');
      } else {
        final newState = CalcState(
          num1: state.value.num1,
          num2: state.value.num2 + input,
          operator: state.value.operator,
          result: decimalHelper(state.value.num2 + input),
        );
        state.value = newState;
        printInfo('onNumber');
      }
    }
  }

  void onOperator(String operation) {
    isOnDecimalCalled = false;
    isOnPercentageCalled = false;
    switch (operation) {
      case '=':
        {
          math();
          //
          state.value = CalcState(
            num1: state.value.num1,
            operator: operation,
            num2: state.value.num2,
            result: decimalHelper(state.value.num1),
          );
          printInfo('onOperator');
          print('onOperator: are we here?, ${state.value.operator}');
          return;
        }
        break;
      default:
        {
          //allows do this: 7 + 4 + = 22.0.
          //Second '+' calls math() for internal calculate
          if (state.value.num2 != '') {
            print('onOperator: default, num2 != null ');
            math();
            print('helper calc for additional operator');
          }
          print('onOperator: default, num2 = null');
          state.value = CalcState(
            num1: state.value.num1,
            num2: state.value.num2,
            operator: operation,
            result: state.value.result,
          );
        }
    }
    isOnDecimalCalled = false;
    isOnPercentageCalled = false;
    printInfo('onOperator');
  }

  void onPercentage() {
//    isOnDecimalCalled = true;
    isOnPercentageCalled = true;
    if (state.value.operator == null) {
      print('onPerc, num1: ${state.value.num1}');
      state.value = CalcState(
        num1: (double.parse(state.value.num1) * 0.01).toString(),
        result:
            decimalHelper((double.parse(state.value.num1) * 0.01).toString()),
      );
    } else {
      print('onPerc, num2: ${state.value.num2}');
      if (state.value.operator == '+' || state.value.operator == '-') {
        state.value = CalcState(
          num1: state.value.num1,
          operator: state.value.operator,
          num2: (double.parse(state.value.num1) *
                  double.parse(state.value.num2) *
                  0.01)
              .toString(),
          result: decimalHelper((double.parse(state.value.num1) *
                  double.parse(state.value.num2) *
                  0.01)
              .toString()),
        );
      } else {
        state.value = CalcState(
            num1: state.value.num1,
            operator: state.value.operator,
            num2: (double.parse(state.value.num2) * 0.01).toString(),
            result: decimalHelper(
                (double.parse(state.value.num2) * 0.01).toString()));
      }
    }
    printInfo('onPercentage');
  }

  //TODO onDecimal has unvcovered cases.
  void onDecimal() {
    if (state.value.result == 'Infinity' ||
        (state.value.num2 == '' &&
            state.value.operator == '=' &&
            decimalHelper(state.value.num1) == state.value.result)) {
      print('clear in onDecimal');
      clear();
    }

    print('onDecimal init, isOnPercentageCalled = $isOnPercentageCalled');
    if (isOnPercentageCalled) {
      print('isOnPercentageCalled');
      if (state.value.operator == null) {
        print(
            'onDecimal, contains DOT,  isOnPercentageCalled = $isOnPercentageCalled');
        state.value = CalcState(num1: '0.', result: '0,');
        isOnDecimalCalled = true;
        return;
      } else {
        state.value = CalcState(
            num1: state.value.num1,
            operator: state.value.operator,
            num2: '0.',
            result: '0,');
        isOnDecimalCalled = true;
        return;
      }
    } else {
      if (state.value.operator == null) {
        if (state.value.num1.contains('.')) {
          return;
        } else {
          print('onDecmal: num1');
          state.value = CalcState(
              num1: state.value.num1 + '.',
              operator: state.value.operator,
              result: state.value.result + ',');
          isOnDecimalCalled = true;
        }
      } else {
        if (state.value.num2 == '') {
          if (state.value.num2.contains('.')) {
            return;
          } else {
            print('onDecmal: num2 = empty ');
            state.value = CalcState(
              num1: state.value.num1,
              num2: '0.',
              operator: state.value.operator,
              result: '0,',
            );
            isOnDecimalCalled = true;
          }
        } else {
          if (state.value.num2.contains('.')) {
            return;
          } else {
            print('onDecmal: num2 = not empty ');
            state.value = CalcState(
              num1: state.value.num1,
              num2: state.value.num2 + '.',
              operator: state.value.operator,
              result: state.value.num2 + ',',
            );
          }
        }
      }
    }
  }

  void onPlusMinus() {
    if (state.value.operator == null) {
      // num1
      if (state.value.num1 == '0') {
        return;
      } else {
        if (state.value.num1.contains('-')) {
          print('we had minus');
          state.value = CalcState(
            num1: state.value.num1.replaceFirst('-', ''),
            result: decimalHelper(state.value.num1.replaceFirst('-', '')),
          );
        } else {
          print('we had plus');
          state.value = CalcState(
              num1: '-' + state.value.num1,
              result: decimalHelper(
                '-' + state.value.num1,
              ));
        }
        printInfo('onPlusMinus');
      }
    } else {
      // num2
      if (state.value.num1.contains('-')) {
        state.value = CalcState(
            num1: state.value.num1.replaceFirst('-', ''),
            result: decimalHelper(
              '-' + state.value.num1.replaceFirst('-', ''),
            ));
      } else {
        if (state.value.num2 != '') {
          state.value = CalcState(
              num1: state.value.num1,
              num2: '-' + state.value.num2,
              operator: state.value.operator,
              result: decimalHelper(
                '-' + state.value.num2,
              ));
        }
      }
      printInfo('onPlusMinus');
    }
  }

  void math() {
    printInfo('math');
    if (state.value.num2 == '') {
      state.value = CalcState(
          num1: state.value.num1,
          operator: state.value.operator,
          num2: state.value.num1,
          result: decimalHelper(state.value.num1));
    }
    switch (state.value.operator) {
      case '+':
        {
          state.value = CalcState(
              num1: (double.parse(state.value.num1) +
                      double.parse(state.value.num2))
                  .toString(),
              operator: state.value.operator,
              result: decimalHelper((double.parse(state.value.num1) +
                      double.parse(state.value.num2))
                  .toString()));
        }
        break;
      case '-':
        {
          state.value = CalcState(
              num1: (double.parse(state.value.num1) -
                      double.parse(state.value.num2))
                  .toString(),
              operator: state.value.operator,
              result: decimalHelper((double.parse(state.value.num1) -
                      double.parse(state.value.num2))
                  .toString()));
        }
        break;
      case '*':
        {
          state.value = CalcState(
              num1: (double.parse(state.value.num1) *
                      double.parse(state.value.num2))
                  .toString(),
              operator: state.value.operator,
              result: decimalHelper((double.parse(state.value.num1) *
                      double.parse(state.value.num2))
                  .toString()));
        }
        break;
      case '/':
        {
          state.value = CalcState(
              num1: (double.parse(state.value.num1) /
                      double.parse(state.value.num2))
                  .toString(),
              operator: state.value.operator,
              result: decimalHelper((double.parse(state.value.num1) /
                      double.parse(state.value.num2))
                  .toString()));
        }
        break;
    }
  }

  void clear() {
    state.value = CalcState();
    print('*******CLEARED******');
    isOnPercentageCalled = false;
    isOnDecimalCalled = false;
  }

  //TODO fails here double is invalid
  String decimalHelper(string) {
    printInfo('decimalHelper');
    numberFormatSymbols['zz'] = new NumberSymbols(
      NAME: "zz",
      DECIMAL_SEP: ',',
      GROUP_SEP: '\u00A0',
      PERCENT: '%',
      ZERO_DIGIT: '0',
      PLUS_SIGN: '+',
      MINUS_SIGN: '-',
      EXP_SYMBOL: 'e',
      PERMILL: '\u2030',
      INFINITY: 'Infinity',
      NAN: 'NaN',
      DECIMAL_PATTERN: '# ##0,###',
      SCIENTIFIC_PATTERN: '#E0',
      PERCENT_PATTERN: '#,##0%',
      CURRENCY_PATTERN: '\u00A4#,##0.00',
      DEF_CURRENCY_CODE: 'AUD',
    );
    final f = new NumberFormat('#,###.#####', 'zz');
    final double dh = double.parse(string);
    return f.format(dh);
  }

  void printInfo(String string) {
    print('$string:  state: num1: ${state.value.num1}, '
        'num2: ${state.value.num2}, '
        'result: ${state.value.result}, '
        'operator: ${state.value.operator}');
  }
}
