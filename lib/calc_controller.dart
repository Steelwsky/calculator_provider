import 'package:flutter/material.dart';

enum Operator { plus, equal }

class CalcState {
  CalcState({this.currentResult = '0'});

  final String currentResult;
}

class CalcController {
  final ValueNotifier<CalcState> state = ValueNotifier(CalcState());

  void onNumberPressed(int buttonValue) {
    final currentResult = state.value.currentResult;
    if (currentResult == '0') {
      final newState = CalcState(currentResult: buttonValue.toString());
      state.value = newState;
    } else {
      final newState =
          CalcState(currentResult: currentResult + buttonValue.toString());
      state.value = newState;
    }
  }

  void onOperationPressed(String operator) {
    final currentResult = state.value.currentResult;
    if (currentResult.contains('+')) {
      return;
    } else {
      final newState = CalcState(currentResult: currentResult + operator);
      state.value = newState;
    }
  }

  void onEqualPressed(string) {
    final currentResult = state.value.currentResult;
    print('currentResult: $currentResult');
    if (currentResult.contains('+')) {
      List splitResult = currentResult.split('+');
      print('splitResult: ${splitResult[0]}, ${splitResult[1]}');
      final newState = CalcState(
          currentResult: (int.parse(splitResult[0]) +
              (splitResult[1] == '' ? 0 : int.parse(splitResult[1])))
              .toString());
      state.value = newState;
    }
  }
}
