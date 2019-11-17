import 'package:flutter/material.dart';

class CalcState {
  CalcState(
      {this.str = '0',
      this.num1 = '0',
      this.num2 = '',
      this.opr = '',
      this.result = '0',
      this.isFirst = true,
      this.isAfterMath = false});

  final String str;
  final String num1;
  final String num2;
  final String opr;
  final String result;
  final bool isFirst;
  final bool isAfterMath;
}

class CalcController {
  final ValueNotifier<CalcState> state = ValueNotifier(CalcState());

  void mainChecker() {}

  void onNumber(String input) {
    if (state.value.opr != '') {
      print('opr is not defined');
      state.value = CalcState(isFirst: false);
    }
    if (state.value.isFirst) {
      state.value = CalcState(num1: '');
      state.value = new CalcState(
          num1: state.value.num1 + input,
          num2: CalcState().num2,
          opr: CalcState().opr,
          isFirst: CalcState().isFirst,
          isAfterMath: CalcState().isAfterMath);

      printInfo();
      return;
    } else {
      state.value = CalcState(num2: state.value.num2 + input);
      printInfo();
    }
  }

  void onOperator(String operator) {
    switch (operator) {
      case '+':
        {
          state.value = new CalcState(
              num1: CalcState().num1,
              num2: CalcState().num2,
              opr: operator,
              isFirst: false,
              isAfterMath: CalcState().isAfterMath);
          printInfo();
        }
        break;
      case '=':
        {
          if (state.value.opr != null) {
            math();
            printInfo();
          } else
            return;
        }
        break;
    }
  }

  void math() {
    if (state.value.opr == '+') {
      state.value = CalcState(
          num1: double.parse(state.value.num1 + state.value.num2).toString(),
          isFirst: false,
          isAfterMath: true);
      return;
    }
  }

  void clear(String clear) {
    state.value = CalcState();
    printInfo();
  }

  void printInfo() {
    print('state: num1: ${state.value.num1} ,'
        ' num2: ${state.value.num2} ,'
        ' opr: ${state.value.opr} ,'
        ' result: ${state.value.result} ,'
        ' isFirst: ${state.value.isFirst}');
  }
}
