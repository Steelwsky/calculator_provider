import 'package:flutter/material.dart';
import 'home_page.dart';
import 'calc_controller.dart';
import 'package:provider/provider.dart';

//TODO enum Operator. implement in onOperator

//DONE add all simple buttons (same color, without icons) but separate zero btn
//TODO add all methods (+ decimal format)
//TODO add tests. Test everything.

//TODO what is dispose
//TODO streams

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
