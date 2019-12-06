import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:intl/number_symbols.dart';

//TODO enum Operator. implement in onOperator
//DONE --- add all simple buttons (same color, without icons) but separate zero btn
//DONE --- add all methods (+ decimal format)
//kind of DONE --- add tests. Test everything.
//TODO what is dispose
//TODO streams

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

  //DONE somehow --- onNumber is very strange now. if(isOnPerc){... if(isOnDecimalCalled) else if(isOnDecimalCalled){}}} need to reformat
  //TODO onNumber is still strange and huge.
  void onNumber(String input) {
    printInfo('onNumber');
    // is needed to be clear
    if (state.value.result == 'Infinity' ||
        (state.value.num2 == '' &&
            state.value.operator == '=' &&
            state.value.num1.replaceAll('.', ',') == state.value.result)) {
      print('clear in onNumber');
      clear();
    }
    // FIRSTNUMBER
    if (state.value.operator == null) {
//      if (isOnPercentageCalled) {
//        print('isOnPercentageCalled, isOnDecimalCalled = true, num1');
//        state.value = CalcState(
//          num1: input,
//          result: input,
//        );
//        isOnPercentageCalled = false;
//        return;
//      }
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
        print('contains(.)');
        final newState = CalcState(
            num1: state.value.num1 + input,
            result: state.value.num1.replaceAll('.', ',') + input);
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

  void onOperator(String operation) {
    // DONE i think it can be much smaller. REDO THIS METHOD
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

  void onDecimal() {
    if (state.value.result == 'Infinity' ||
        (state.value.num2 == '' &&
            state.value.operator == '=' &&
            state.value.num1.replaceAll('.', ',') == state.value.result)) {
      print('clear in onDecimal');
      clear();
    }
    if (state.value.num1.contains('.') && state.value.operator == null) {
      print(
          'onDecimal, contains DOT,  isOnPercentageCalled = $isOnPercentageCalled');
      //esli 5% a potom najat 5, to budet 5.
      if (isOnPercentageCalled) {
        state.value = CalcState(num1: '0.', result: '0,');
        isOnDecimalCalled = true;
        return;
      }
    } else {
      if (state.value.operator == null) {
        print('onDecmal: num1');
        state.value = CalcState(
            num1: state.value.num1 + '.',
            operator: state.value.operator,
            result: state.value.result + ',');
        isOnDecimalCalled = true;
      } else {
        print('onDecmal: num2');
        state.value = CalcState(
          num1: state.value.num1,
          num2: '0.',
          operator: state.value.operator,
          result: '0,',
        );
        isOnDecimalCalled = true;
      }
    }
  }

  // onPlusMinus() doesn't have case which allows to +- after app is pimped and have -0
  void onPlusMinus() {
    if (state.value.operator == null) {
      // num1
      if (state.value.num1 == '0') {
        return;
//        state.value = CalcState(num1: '-0', result: '-0');
//        printInfo();
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
    isOnDecimalCalled = false;
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
//    final double doubleNumber = double.parse(string);
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
      DECIMAL_PATTERN: '# ##0.###',
      SCIENTIFIC_PATTERN: '#E0',
      PERCENT_PATTERN: '#,##0%',
      CURRENCY_PATTERN: '\u00A4#,##0.00',
      DEF_CURRENCY_CODE: 'AUD',
    );
    final f = new NumberFormat('#,###.#####', 'zz');
    final double dh = double.parse(string);
    return f.format(dh);
//    f.format(number);
  }

  void printInfo(String string) {
    print('$string:  state: num1: ${state.value.num1}, '
        'num2: ${state.value.num2}, '
        'result: ${state.value.result}, '
        'operator: ${state.value.operator}');
  }
}
