import 'package:flutter/material.dart';

enum Operator { plus, equal }

class CalcState {
  CalcState({this.currentResult = '0'});

  final String currentResult;
}

class CalcController {
  final ValueNotifier<CalcState> state = ValueNotifier(CalcState());

  void onNumberPressed(int buttonValue) {
    state.value = CalcState(currentResult: buttonValue.toString());
  }
}
