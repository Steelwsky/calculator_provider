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
}
