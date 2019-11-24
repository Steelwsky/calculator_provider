import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calc_controller.dart';
import 'widgets/text_view.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final calcController = Provider.of<CalcController>(context);
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextView(),
          FlatButton(
              onPressed: () {
                calcController.onNumberPressed(1);
              },
              child: Text('1'),
              key: ValueKey('button1')),
          FlatButton(onPressed: () {
            calcController.onEqualPressed;
          }, child: Text('='), key: ValueKey('equalButton')),
          FlatButton(onPressed: () {
            calcController.onOperationPressed('+');
          }, child: Text('+'), key: ValueKey('plusButton')),
          FlatButton(onPressed: () {}, child: Text('CLEAR'), key: ValueKey('clearButton')),
        ],
      )),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
