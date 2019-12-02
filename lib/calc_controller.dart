import 'package:flutter/material.dart';

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

  //TODO call clear() in this case: 4 + 7 = 4 +. Now i get 15, but i want to receive 4.
  void onNumber(String input) {
    print('onNumber: ');
    printInfo();
    if (state.value.result == 'Infinity' ||
        (state.value.num2 == '' &&
            state.value.operator == '=' &&
            state.value.num1 == state.value.result)) {
      print('clear in onNumber');
      clear();
    }
    if (state.value.operator == null) {
      if (state.value.num1 == '0') {
        final newState = CalcState(num1: input, result: input);
        state.value = newState;
        printInfo();
      } else {
        final newState = CalcState(
          num1: state.value.num1 + input,
          result: state.value.num1 + input,
        );
        state.value = newState;
        printInfo();
      }
    } else {
      final newState = CalcState(
        num1: state.value.num1,
        num2: state.value.num2 + input,
        operator: state.value.operator,
        result: state.value.num2 + input,
      );
      state.value = newState;
      printInfo();
    }
  }

  void onOperator(String operation) {
    // DONE i think it can be much smaller. REDO THIS METHOD
    // TODO remove '=' from this method to a separate one. Maybe not.
    switch (operation) {
      case '=':
        {
          math();
          state.value = CalcState(
            num1: state.value.num1,
            operator: operation,
            num2: state.value.num2,
            result: state.value.result,
          );
          printInfo();
          print('are we here?, ${state.value.operator}');
          return;
        }
        break;
      default:
        {
          //allows do this: 7 + 4 + = 22.0.
          //Second '+' calls math() for internal calculate
          if (state.value.operator != '=' && state.value.num2 != '') {
            math();
            print('helper calc for additional operator');
          }
          state.value = CalcState(
            num1: state.value.num1,
            num2: state.value.num2,
            operator: operation,
            result: state.value.result,
          );
        }
    }
    printInfo();
  }

//  void onPercentage() {}
//
//  void onPlusMinus() {}
//

  void onDecimal() {
    if (state.value.result == 'Infinity' ||
        (state.value.num2 == '' &&
            state.value.operator == '=' &&
            state.value.num1 == state.value.result)) {
      print('clear in onDecimal');
      clear();
    }
    if (state.value.num1.contains('.')) {
      return;
    } else {
      if (state.value.operator == null) {
        print('onDecmal: num1');
        state.value = CalcState(
            num1: state.value.num1 + '.',
            operator: state.value.operator,
            result: state.value.num1 + '.');
      } else {
        print('onDecmal: num2');
        state.value = CalcState(
            num1: state.value.num1,
            num2: state.value.num2 + '0' + '.',
            operator: state.value.operator,
            result: state.value.num2 + '0' + '.');
      }
    }
  }

  void math() {
    printInfo();
    if (state.value.num2 == '') {
      state.value = CalcState(
          num1: state.value.num1,
          operator: state.value.operator,
          num2: state.value.num1,
          result: state.value.result);
    }
    switch (state.value.operator) {
      case '+':
        {
          state.value = CalcState(
              num1: (double.parse(state.value.num1) +
                      double.parse(state.value.num2))
                  .toString(),
              operator: state.value.operator,
              result: (double.parse(state.value.num1) +
                      double.parse(state.value.num2))
                  .toString());
        }
        break;
      case '-':
        {
          state.value = CalcState(
              num1: (double.parse(state.value.num1) -
                      double.parse(state.value.num2))
                  .toString(),
              operator: state.value.operator,
              result: (double.parse(state.value.num1) -
                      double.parse(state.value.num2))
                  .toString());
        }
        break;
      case '*':
        {
          state.value = CalcState(
              num1: (double.parse(state.value.num1) *
                      double.parse(state.value.num2))
                  .toString(),
              operator: state.value.operator,
              result: (double.parse(state.value.num1) *
                      double.parse(state.value.num2))
                  .toString());
        }
        break;
      case '/':
        {
          state.value = CalcState(
              num1: (double.parse(state.value.num1) /
                      double.parse(state.value.num2))
                  .toString(),
              operator: state.value.operator,
              result: (double.parse(state.value.num1) /
                      double.parse(state.value.num2))
                  .toString());
        }
        break;
    }
  }

  void clear() {
    state.value = CalcState();
//    printInfo();
    print('*******CLEARED******');
  }

  void printInfo() {
    print('state: num1: ${state.value.num1}, '
        'num2: ${state.value.num2}, '
        'result: ${state.value.result}, '
        'operator: ${state.value.operator}');
  }
}
