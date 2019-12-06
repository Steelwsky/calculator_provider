import 'package:flutter/material.dart';
import 'home_page.dart';
import 'calc_controller.dart';
import 'package:provider/provider.dart';



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
