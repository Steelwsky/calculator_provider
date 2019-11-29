import 'package:flutter/material.dart';

class CalcState {
  CalcState(
      {this.num1 = '0', this.num2 = '', this.result = '0', this.operator});

  final String num1;
  final String num2;
  final String result;
  final String operator;
}

class CalcController {
  final ValueNotifier<CalcState> state = ValueNotifier(CalcState());

  void onNumber(String input) {
    if (state.value.operator == null) {
      if (state.value.num1 == '0') {
        final newState = CalcState(num1: input, result: input);
        state.value = newState;
        printInfo();
      } else {
        final newState = CalcState(
            num1: state.value.num1 + input, result: state.value.num1 + input);
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
    switch (operation) {
      case '+':
        {
          state.value = CalcState(
            num1: state.value.num1,
            num2: state.value.num2,
            operator: operation,
            result: state.value.result,
          );
        }
        break;
      case '-':
        {
          state.value = CalcState(
            num1: state.value.num1,
            num2: state.value.num2,
            operator: operation,
            result: state.value.result,
          );
        }
        break;
      case '=':
        {
          math();
          printInfo();
        }
        break;
    }
  }

//  void onPercentage() {}
//
//  void onPlusMinus() {}
//
//  void onDecimal() {}

  void math() {
    if (state.value.num2.isEmpty) {
      state.value = CalcState(
          num1: state.value.num1,
          operator: state.value.operator,
          num2: '0',
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
          return;
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
        {}
        break;
      case '/':
        {}
        break;
    }
  }

  void clear(String clear) {
    state.value = CalcState();
    printInfo();
  }

  void printInfo() {
    print(
        'state: num1: ${state.value.num1}, num2: ${state.value
            .num2}, result: ${state.value.result}, operator: ${state.value
            .operator}');
  }
}
