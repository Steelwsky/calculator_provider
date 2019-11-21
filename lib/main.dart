import 'package:flutter/material.dart';
import 'home_page.dart';
import 'calc_controller.dart';
import 'package:provider/provider.dart';

//DONE tests
//DONE result?
//TODO enum Operator. implement in onOperator

//TODO add all simple buttons (same color, without icons) but separate zero btn
//TODO add all methods (+ decimal format)
//TODO add tests. Test everything.

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provider<CalcController>(builder: (_) => CalcController(), child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    ));
  }
}
