import 'package:flutter/material.dart';

enum Operator { plus, equal }

class CalcState {
  CalcState({this.num1 = '0', this.num2 = '', this.operator});

  final String num1;
  final String num2;
  final String operator;
}

class CalcController {
  final ValueNotifier<CalcState> state = ValueNotifier(CalcState());

  void onNumber(String input) {
//    printInfo();
    if (state.value.operator == null) {
      state.value =
          CalcState(num1: state.value.num1.replaceAll('0', '') + input);
//      printInfo();
    } else {
      state.value = CalcState(
          num1: state.value.num1,
          num2: state.value.num2 + input,
          operator: state.value.operator);
    }
  }

//  void clear(String clear) {
//    state.value = CalcState();
//    printInfo();
//  }

//  void onOperator(String operation) {
//    switch (operation) {
//      case '+':
//        {
//          state.value = CalcState(num1: state.value.num1, operator: operation);
//          printInfo();
//        }
//        break;
//      case '=':
//        {
//          if (state.value.operator != null) {
//            math();
//            printInfo();
//          } else
//            return;
//        }
//        break;
//    }
//  }

//  void math() {
//    if (state.value.operator == '+') {
//      state.value = CalcState(
//          num1: (double.parse(state.value.num1) + double.parse(state.value.num2)).toString());
//      return;
//    }
//  }
//
//  void printInfo() {
//    print('state: num1: ${state.value.num1}, num2: ${state.value.num2}, operator: ${state.value.operator}');
//  }
}
