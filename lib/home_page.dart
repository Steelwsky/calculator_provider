import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calc_controller.dart';
import 'widgets/button.dart';
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
            Row(
              children: <Widget>[
                MyButton(str: 'AC', func: calcController.clear),
                MyButton(str: '+-', func: calcController.onOperator),
                MyButton(str: '%', func: calcController.onOperator),
                MyButton(str: '/', func: calcController.onOperator),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            Row(
              children: <Widget>[
                MyButton(str: '7', func: calcController.onNumber),
                MyButton(str: '8', func: calcController.onNumber),
                MyButton(str: '9', func: calcController.onNumber),
                MyButton(str: '*', func: calcController.onOperator),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            Row(
              children: <Widget>[
                MyButton(str: '4', func: calcController.onNumber),
                MyButton(str: '5', func: calcController.onNumber),
                MyButton(str: '6', func: calcController.onNumber),
                MyButton(str: '-', func: calcController.onOperator),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            Row(
              children: <Widget>[
                MyButton(str: '1', func: calcController.onNumber),
                MyButton(str: '2', func: calcController.onNumber),
                MyButton(str: '3', func: calcController.onNumber),
                MyButton(str: '+', func: calcController.onOperator),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            Row(
              children: <Widget>[
                MyButton(str: '0', func: calcController.onNumber),
                MyButton(str: ',', func: calcController.onNumber),
                MyButton(str: '=', func: calcController.onOperator),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            )
          ],
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
