import 'package:flutter/material.dart';

enum Operator { plus, equal }

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
//    printInfo();
    if (state.value.operator == null) {
      state.value = CalcState(
          num1: state.value.num1.replaceAll('0', '') + input,
          result: state.value.num1.replaceAll('0', '') + input);
      printInfo();
    } else {
      state.value = CalcState(
          num1: state.value.num1,
          num2: state.value.num2 + input,
          result: state.value.num2 + input,
          operator: state.value.operator);
      printInfo();
    }
  }

  void onOperator(String operation) {
    switch (operation) {
      case '%':
        {
          onPercentage();
        }
        break;
      case '+-':
        {
          onPlusMinus();
        }
        break;
      case ',':
        {
          onDecimal();
        }
        break;
      case '=':
        {
          if (state.value.operator != null) {
            math();
            printInfo();
          } else
            return;
        }
        break;
      default:
        {
          if (state.value.num1 != '' && state.value.operator != null) {
            if (state.value.num2 != '') {
              math();
              printInfo();
            } else {
              //TODO тут загвоздка в operator: operation. если мы сделаем 7+9+= то сохранится =, а нужен +, но state уже сменился и получить предыдущий оператор не представляется возможным
              state.value = CalcState(num1: state.value.num1,
                  num2: state.value.num1,
                  result: state.value.num1,
                  operator: operation);
              math();
              printInfo();
            }
          }
          else {
            state.value = CalcState(
                num1: state.value.num1,
                result: state.value.num1,
                operator: operation);
            printInfo();
          }
        }
    }
  }

  void onPercentage() {}

  void onPlusMinus() {}

  void onDecimal() {}

  void math() {
//    if (state.value.operator == '+') {
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
